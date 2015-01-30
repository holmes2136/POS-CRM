<%@ WebHandler Language="C#" Class="CustIdIsExists" %>



using System;
using System.Web;

public class CustIdIsExists : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        context.Response.Write("Hello World");
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}