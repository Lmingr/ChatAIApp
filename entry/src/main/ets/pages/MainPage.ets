import { TabComponent } from '../view/TabComponent'


@Entry
@Component
struct  MainPage{

  @State currentIndex: number = 0

  statusBar: number = AppStorage.get<number>('statusBar') as number

  build() {
    Column(){
      TabComponent({ currentIndex: this.currentIndex })
    }
    .padding({top:this.statusBar})
    .height(`100%`)
    .width(`100%`)
  }

}