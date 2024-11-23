import { TabComponent } from '../view/TabComponent'


@Entry
@Component
struct  MainPage{

  @State currentIndex: number = 1

  build() {
    Column(){
      TabComponent({ currentIndex: this.currentIndex })
    }
    .height(`100%`)
    .width(`100%`)
  }

}