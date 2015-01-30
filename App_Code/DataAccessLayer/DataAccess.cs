using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Data.SqlClient;
using VO;
using System.Collections;
using System.Collections.Generic;
using Config = System.Configuration.ConfigurationManager;

namespace DataAccessLayer
{
    /// <summary>
    /// DataAccess 的摘要描述
    /// </summary>
    public abstract class DataAccess
    {
        public DataAccess(){}

        public string GetConnectionString()
        {

            string connStr = "";

            if (!String.IsNullOrEmpty(Config.AppSettings["MM_CONNECTION_STRING_linkC001"]))
                connStr = Config.AppSettings["MM_CONNECTION_STRING_linkC001"];
                                                   
            else
                throw new NullReferenceException("ConnectionString is missing");


            return connStr;


        }

        //SQL Methods
        public abstract void setCommandType(SqlCommand sqlCmd, CommandType cmdType, string cmdText);
        public abstract object ExecuteScalarCmd(SqlCommand sqlCmd);
        public abstract void AddParamToSQLCmd(SqlCommand sqlCmd, string paramId, SqlDbType sqlType, int paramSize, ParameterDirection paramDirection, object paramvalue);
        public abstract DataTable ExecuteScalarCmd3(SqlCommand cmd);


        //Customer Methods
        public abstract Customer CustInfo(string CustID);
        public abstract Comm CommInfo(string CustId);



        //Glasses Orders
        public abstract DataTable getGlassesOrders(string CustId);
        public abstract GlassesOrders getLatestGlassesOrders(string CustId);
        public abstract DataTable CustList(int pageindex, int pagesize, string CustId, string CustName, string CustTelPhone,
                                                string CustMobile,string CustAddress);

        //Liquid Orders 
        public abstract DataTable getLiquidOrders(string CustId);


        //Call Center
        public abstract CallCenter getCallCenter(string CustId);

        //User
        public abstract object[] getUser(string account, string pwd);

    }

}
