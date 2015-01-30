using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Collections;
using System.Collections.Generic;

namespace Util
{
    /// <summary>
    /// PageUtil 的摘要描述
    /// </summary>
    public class PageUtil
    {

        //private  Dictionary<string, string> allowUrl = new Dictionary<string, string>() { {"/POS-CRM/index.aspx", "/POS-CRM/index.aspx"}  };
      
        	

        public PageUtil()
        {
          
        }

        public static bool IsAllowedUrl(string referUrl)
        {
            //bool IsAllow = false;

            //if (allowUrl.ContainsKey(referUrl))
            //    IsAllow = true;
            //else
            //    IsAllow = false;

            //return IsAllow;
            return true;
        }

        public static object IIf(bool cond, object left, object right)
        {
            return cond ? left : right;
        }


    }

}
