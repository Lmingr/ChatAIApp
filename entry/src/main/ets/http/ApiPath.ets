
export  class  ApiPath{
  public static  baseUrl="http://luomingrong.site:8090/";
  // public static  baseUrl="http://114.132.225.103:8090/";
  public static  login=ApiPath.baseUrl+"users/login";
  public static  register=ApiPath.baseUrl+"users/register";

  public static  foundList=ApiPath.baseUrl+"users/foundlist?username="


  public static  foundMessage=ApiPath.baseUrl+"users/foundmessage?mid="


  public static  xfUrl="https://spark-api-open.xf-yun.com/v1/chat/completions"
}