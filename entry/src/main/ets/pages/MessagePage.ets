import { MessageInfoModel } from "../bean/MessageInfoModel"
import { BottomComponent } from "../view/BottomComponent"
import MessageComponent from "../view/MessageComponent"
import { chatMessageViewModel } from "../viewModel/ChatMessageViewModel"
import { router } from "@kit.ArkUI"
import { Logger } from "../utils/Logger"
import { MessageLoadingComponent } from "../view/MessageLoadingComponent"


@Component
export struct MessagePage{

    build() {
      Column(){
        Button(`点击进入聊天`)
          .onClick(()=>{
            router.pushUrl({url:'pages/ChatToAIPage"'})
          })
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .height(`100%`)
      .width(`100%`)
    }

}

