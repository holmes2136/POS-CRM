using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;


namespace VO
{
    /// <summary>
    /// User 的摘要描述
    /// </summary>
    public class User
    {
        public string username { get; set; }
        public string pwd { get; set; }

        public User()
        {
           
        }

        public static object[] getUser(string login_ID, string userHash)
        {

            return DataAccessLayer.DataAccessHelper.getDataAccess().getUser(login_ID, userHash);

        }
    }

}