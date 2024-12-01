import { HistoryPage } from "../pages/HistoryPage"
import { MessagePage } from "../pages/MessagePage"
import { MinePage } from "../pages/MinePage"


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
      Tabs({ barPosition: BarPosition.End, controller: this.tabsController,index:1 }) {
        TabContent() {
          MessagePage()
        }.tabBar(this.tabBuilder("chat", 0, $r("app.media.messages_select"), $r("app.media.messages") ))

        TabContent() {
          HistoryPage()
        }.tabBar(this.tabBuilder("saved", 1, $r("app.media.archive_add"), $r("app.media.vuesax_archive_add") ))

      }
    }


  }
}