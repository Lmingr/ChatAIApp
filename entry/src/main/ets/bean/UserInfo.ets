

export class  UserInfo{
  uid:number=0;
  username:string='';
  password:string='';
  salt:string='';
  phone:string='';
  email:string='';
  avater:string='';
  gender:string='';
  isDelete:number=0;
  createdUser:string='';
  modifiedUser :string='';
  createdTime:Date=new Date();
  modifiedTime:Date=new Date();
}