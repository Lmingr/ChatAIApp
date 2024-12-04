import { router } from "@kit.ArkUI"
import { Logger } from "../utils/Logger"


@Component
export struct MessagePage{

  build() {
    Column(){
      Button(`新建聊天`)
        .onClick(()=>{
          router.pushUrl({url:'pages/ChatToAIPage',params:{isNewChat:true}})
        })
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .height(`100%`)
    .width(`100%`)
  }

}

