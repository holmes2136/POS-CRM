using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

namespace DataAccessLayer
{
    /// <summary>
    /// DataAccessHelper 的摘要描述
    /// </summary>
    public class DataAccessHelper
    {
        public DataAccessHelper()
        {
            //
            // TODO: 在此加入建構函式的程式碼
            //
        }

        public static DataAccess getDataAccess()
        {


            DataAccess da = new SQLDataAccess();

            return da;
        }
    }

}