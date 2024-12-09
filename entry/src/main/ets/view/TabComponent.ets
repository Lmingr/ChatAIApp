import { UserMessage } from "../bean/UserMessage"
import { HistoryPage } from "../pages/HistoryPage"
import { MessagePage } from "../pages/MessagePage"
import { MinePage } from "../pages/MinePage"
import { Logger } from "../utils/Logger"
import { historyViewModel } from "../viewModel/HistoryViewModel"


@Component
export  struct   TabComponent{

  private  tabsController:TabsController=new TabsController()


  @Link currentIndex:number

  @Builder tabBuilder(title: string, targetIndex: number, selectedImg: Resource, normalImg: Resource){
    Column() {
      Image(this.currentIndex === targetIndex ? selectedImg : normalImg)
        .size({ width: 24, height: 24 })
      Text(title)
        .margin({ top: 3 })
        .fontColor(this.getTabTextColor(this.currentIndex, targetIndex))
    }
    .width(`100%`)
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      this.tabsController.changeIndex(targetIndex)
      this.currentIndex = targetIndex
    })
  }

  private  getTabTextColor(currentIndex: number, targetIndex: number) {
    return currentIndex === targetIndex ?  "#17C3CE":Color.Black
  }


  build() {
    Stack() {
      Tabs({ barPosition: BarPosition.End, controller: this.tabsController,index:0 }) {
        TabContent() {
          MessagePage()
        }.tabBar(this.tabBuilder("chat", 0, $r("app.media.messages_select"), $r("app.media.messages") ))

        TabContent() {
          MinePage()
        }
        .tabBar(this.tabBuilder("mine", 1, $r("app.media.person_select"), $r("app.media.person") ))
      }
      .onChange((index: number) => {
        // currentIndex控制TabContent显示页签
        this.currentIndex = index
      })
    }


  }
}