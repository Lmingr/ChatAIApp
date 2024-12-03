import { MessageBean } from "./MessageBean"


export class  UserMessage{
  private _mid: number

  public set mid(value: number) {
    this._mid = value
  }

  public get mid(): number {
    return this._mid
  }

  private _username: string

  public set username(value: string) {
    this._username = value
  }

  public get username(): string {
    return this._username
  }

  private _messageTopic: string

  public set messageTopic(value: string) {
    this._messageTopic = value
  }

  public get messageTopic(): string {
    return this._messageTopic
  }

  private _messageContent: string

  public set messageContent(value: string) {
    this._messageContent = value
  }

  public get messageContent(): string {
    return this._messageContent
  }

  private _messageDate: Date

  public set messageDate(value: Date) {
    this._messageDate = value
  }

  public get messageDate(): Date {
    return this._messageDate
  }

  private _messageList: MessageBean[]

  public set messageList(value: MessageBean[]) {
    this._messageList = value
  }

  public get messageList(): MessageBean[] {
    return this._messageList
  }

  constructor(mid: number, username: string, messageTopic: string, messageContent: string, messageDate: Date,
    messageList: MessageBean[]) {
    this._mid = mid
    this._username = username
    this._messageTopic = messageTopic
    this._messageContent = messageContent
    this._messageDate = messageDate
    this._messageList = messageList
  }

}