using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

namespace Util
{

    /// <summary>
    /// DBUtil 的摘要描述
    /// </summary>
    public class DBUtil
    {
        public DBUtil()
        {
            
        }

        public static string addQuot(string source)
        {
            return "'" + source.Replace("'", "''").Replace("&nbsp;", "").Trim() + "'";
        }

    }


}