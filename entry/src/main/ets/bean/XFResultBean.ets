

export  class  XFResultBean{
  code:  number
  message:  string
  sid:string
  choices:  Choices[]
  usage: Usage

  constructor(code: number, message: string, sid: string, choices: Choices[], usage: Usage) {
    this.code = code
    this.message = message
    this.sid = sid
    this.choices = choices
    this.usage = usage
  }
}

export class Choices{
  message: Message
  index:number
  constructor(message: Message, index: number) {
    this.message = message
    this.index = index
  }
}

export  class Message{
  role:string=""
  content:string=""
}

export   class Usage{
  prompt_tokens:number=0;
  completion_tokens:number=0;
  total_tokens:number=0;
}


