export  class  XFResultStreamBean{
  code:  number
  message:  string
  sid:string
  id:string
  created:number
  choices:  Choices[]

  constructor(code: number, message: string, sid: string, id: string, created: number, choices: Choices[]) {
    this.code = code
    this.message = message
    this.sid = sid
    this.id = id
    this.created = created
    this.choices = choices
  }

}

export class Choices{
  delta: Delta
  index:number

  constructor(delta: Delta, index: number) {
    this.delta = delta
    this.index = index
  }

}

export  class Delta{
  role:string=""
  content:string=""
}

export   class Usage{
  prompt_tokens:number=0;
  completion_tokens:number=0;
  total_tokens:number=0;
}


