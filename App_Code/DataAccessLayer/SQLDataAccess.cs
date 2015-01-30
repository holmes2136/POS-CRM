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
using System.Collections;
using System.Collections.Generic;
using VO;
using Util;
using System.Text;

namespace DataAccessLayer
{
    /// <summary>
    /// SQLDataAccess 的摘要描述
    /// </summary>
    public class SQLDataAccess : DataAccess
    {
        private delegate void TGenerateListFromReader<t>(SqlDataReader returnData, ref List<t> List);

        public SQLDataAccess()
        {

        }

        public override void AddParamToSQLCmd(SqlCommand sqlCmd, string paramId, SqlDbType sqlType, int paramSize, System.Data.ParameterDirection paramDirection, object paramvalue)
        {
            if (sqlCmd == null)
            {
                throw new ArgumentException("sqlCmd");
            }

            if (paramId == string.Empty)
            {
                throw new ArgumentOutOfRangeException("paramId");
            }

            SqlParameter newSqlParam = new SqlParameter();
            newSqlParam.ParameterName = paramId;
            newSqlParam.SqlDbType = sqlType;
            newSqlParam.Direction = paramDirection;

            if (paramSize > 0)
            {
                newSqlParam.Size = paramSize;
            }

            if (paramvalue != null)
            {
                newSqlParam.Value = paramvalue;
            }

            sqlCmd.Parameters.Add(newSqlParam);
        }

        public override void setCommandType(SqlCommand sqlCmd, CommandType cmdType, string cmdText)
        {
            sqlCmd.CommandText = cmdText;
            sqlCmd.CommandType = cmdType;

        }


        public override object ExecuteScalarCmd(SqlCommand sqlCmd)
        {

            if (this.GetConnectionString() == string.Empty)
            {
                throw new ArgumentNullException("connectionString");
            }

            if (sqlCmd == null)
            {
                throw new ArgumentNullException("SqlCmd");
            }

            using (SqlConnection conn = new SqlConnection(this.GetConnectionString()))
            {

                sqlCmd.Connection = conn;

                conn.Open();

                object obj = sqlCmd.ExecuteScalar();

                return obj;

            }
        }

        public override DataTable ExecuteScalarCmd3(SqlCommand sqlCmd)
        {
            DataTable dt = null;

            if (this.GetConnectionString() == string.Empty)
            {
                throw new ArgumentNullException("ConnectionString");
            }

            using (SqlConnection conn = new SqlConnection(this.GetConnectionString()))
            {
                sqlCmd.Connection = conn;

                conn.Open();

                dt = new DataTable();

                dt.Load(sqlCmd.ExecuteReader());

                return dt;

            }
        }


        private void TExecuteReaderCmd<t>(SqlCommand sqlCmd, TGenerateListFromReader<t> gcfr, ref List<t> List)
        {
            if (string.IsNullOrEmpty(this.GetConnectionString()))
            {
                throw new ArgumentOutOfRangeException("ConnectionString");
            }

            if (sqlCmd == null)
            {
                throw new ArgumentOutOfRangeException("sqlCmd");
            }

            using (SqlConnection conn = new SqlConnection(GetConnectionString()))
            {
                sqlCmd.Connection = conn;
                conn.Open();
                gcfr(sqlCmd.ExecuteReader(), ref List);

            }
        }


        //Customer Methods
        public override Customer CustInfo(string CustId) {

            SqlCommand cmd = new SqlCommand();
            
            string sql = "SELECT *  FROM 客戶資料表  WHERE CustId = @CustID";

            cmd.CommandText = sql;

            cmd.Parameters.Add("@CustId",SqlDbType.VarChar,0).Value = CustId;

            DataTable dt = ExecuteScalarCmd3(cmd);

            Customer cust = new Customer();
            cust.CustName = dt.Rows[0]["CustName"].ToString();
            cust.CustId = CustId;
            cust.CustEmail = dt.Rows[0]["CustEmail"].ToString();
            cust.Contect = dt.Rows[0]["Contect"].ToString();
            cust.CustMobile = dt.Rows[0]["CustMobile"].ToString();
            cust.CustTelPhone = dt.Rows[0]["CustTelPhone"].ToString();
            cust.Serial = Convert.ToInt32(dt.Rows[0]["Serial"].ToString());
            cust.CustAddr = dt.Rows[0]["CustAddress"].ToString();
            
            return cust;
            
        }

        public override DataTable CustList(int pageindex,int pagesize,string CustId,
                                           string CustName, string CustTelPhone, 
                                           string CustMobile, string CustAddress)
        {
            SqlCommand cmd = new SqlCommand();
            StringBuilder sql = new StringBuilder();

            sql.Append("SELECT * from  ( SELECT ROW_NUMBER() OVER(ORDER BY NEWID())As RowSort,Serial,CustId,CustName,CustTelPhone,CustMobile,CustEmail,CustAddress");
            sql.Append(" FROM 客戶資料表 ) As A");
            sql.Append(" WHERE 1=1");

            if (!string.IsNullOrEmpty(CustId)) {
                sql.AppendFormat(" AND CustID Like {0}",DBUtil.addQuot(CustId));
                cmd.Parameters.Add("@CustId", SqlDbType.VarChar, 0).Value = CustId;
            }

            if (!string.IsNullOrEmpty(CustName))
            {
                sql.AppendFormat(" AND CustName Like {0}", DBUtil.addQuot(CustName));
                cmd.Parameters.Add("@CustName", SqlDbType.VarChar, 0).Value = CustName;
            }

            if (!string.IsNullOrEmpty(CustTelPhone))
            {
                sql.AppendFormat(" AND CustTelPhone Like {0}", DBUtil.addQuot(CustTelPhone));
                cmd.Parameters.Add("@CustTelPhone", SqlDbType.VarChar, 0).Value = CustTelPhone;
            }

            if (!string.IsNullOrEmpty(CustMobile))
            {
                sql.AppendFormat(" AND CustMobile Like {0}", DBUtil.addQuot(CustMobile));
                cmd.Parameters.Add("@CustMobile", SqlDbType.VarChar, 0).Value = CustMobile;
            }
            
            if (!string.IsNullOrEmpty(CustAddress))
            {
                sql.AppendFormat(" AND CustAddress Like {0}", DBUtil.addQuot(CustAddress));
                cmd.Parameters.Add("@CustAddress", SqlDbType.VarChar, 0).Value = CustAddress;
            }

            sql.Append(GetRowNumber(pageindex, pagesize));

            sql.Append(" ORDER BY Serial DESC");

            cmd.CommandText = sql.ToString();

            DataTable dt = this.ExecuteScalarCmd3(cmd);

            return dt;
        }

        public override Comm CommInfo(string CustId)
        {

            SqlCommand cmd = new SqlCommand();

            string sql = "SELECT * FROM 客戶通訊資料庫 WHERE CustId = @CustId";

            cmd.CommandText = sql;

            cmd.Parameters.Add("@CustId",  SqlDbType.VarChar, 0).Value = CustId;

            DataTable dt = ExecuteScalarCmd3(cmd);

            Comm comm = new Comm(); ;

            if (dt.Rows.Count > 0)
            {
                comm.Serial = Convert.ToInt32(dt.Rows[0]["Serial"].ToString());
                comm.Content = dt.Rows[0]["Content"].ToString();
            }

            return comm;

        }


        public override DataTable getGlassesOrders(string CustId)
        {
            GlassesOrders order = null;

            SqlCommand cmd = new SqlCommand();

            string sql = "SELECT * FROM 日報表1 WHERE CustId = @CustId";

            cmd.CommandText = sql;

            cmd.Parameters.Add("@CustId", SqlDbType.VarChar, 0).Value = CustId;

            DataTable dt = ExecuteScalarCmd3(cmd);

            return dt;
        }


        public override GlassesOrders getLatestGlassesOrders(string CustId)
        {
            GlassesOrders order = null;

            SqlCommand cmd = new SqlCommand();

            string sql = "select top 1 * from (SELECT TOP 99.99 PERCENT *  FROM 日報表1 Where CustId = @CustId order by publishday desc)AS A ";

            cmd.CommandText = sql;

            cmd.Parameters.Add("@CustId", SqlDbType.VarChar, 0).Value = CustId;

            using (SqlConnection conn = new SqlConnection(this.GetConnectionString())) {

                cmd.Connection = conn;
                conn.Open();

                SqlDataReader reader = cmd.ExecuteReader();

                order = new GlassesOrders();

                while (reader.Read()) {
                         order.Balance = reader["Balance"].ToString();
                         order.BillNumber = reader["BillNumber"].ToString();
                         order.Contect = reader["Contect"].ToString();
                         order.LeftDegrees = reader["LeftDegrees"].ToString();
                         order.PinClass = reader["PinClass"].ToString();
                         order.PinManufacturerR = reader["PinManufacturerR"].ToString();
                         order.ProductName = reader["ProductName"].ToString();
                         order.PublishDay = reader["PublishDay"].ToString();
                         order.RightDegrees = reader["RightDegrees"].ToString();
                         order.SalesMan = reader["SalesMan"].ToString();
                         order.SellPrice = reader["SellPrice"].ToString();
                         order.SystemTime = reader["SystemTime"].ToString();
                        
                }
            }

            return order;
        }

        public override DataTable getLiquidOrders(string CustId)
        {
            SqlCommand cmd = new SqlCommand();

            string sql = "SELECT * FROM 日報表2  Where CustId = @CustId ORDER BY PublishDay DESC";

            cmd.CommandText = sql;

            cmd.Parameters.Add("@CustId", SqlDbType.VarChar, 0).Value = CustId;

            DataTable dt = ExecuteScalarCmd3(cmd);

            return dt;

        }


        public override CallCenter getCallCenter(string CustId) {

            SqlCommand cmd = new SqlCommand();

            string sql = "SELECT * FROM 客服記錄 WHERE CustId = @CustId";

            cmd.CommandText = sql;

            cmd.Parameters.Add("@CustId", SqlDbType.VarChar, 0).Value = CustId;

            DataTable dt = ExecuteScalarCmd3(cmd);

            CallCenter cc = new CallCenter(); ;

            if (dt.Rows.Count > 0)
            {
                cc.Serial = Convert.ToInt32(dt.Rows[0]["Serial"].ToString());
                cc.UnderTaker = dt.Rows[0]["UnderTaker"].ToString();
                cc.ServiceContent = dt.Rows[0]["ServiceContent"].ToString();
                cc.SystemTime = dt.Rows[0]["SystemTime"].ToString();
            }

            return cc;
        }

        public override object[] getUser(string account, string pwd)
        {
            string userHash = Security.HashPassword(pwd);

            SqlCommand cmd = new SqlCommand();

            string sql = "SELECT *  FROM 分店員工資料表  WHERE Login_Id = @Login_Id and UserHash = @UserHash ";

            cmd.CommandText = sql;

            cmd.Parameters.Add("@Login_Id", SqlDbType.VarChar, 0).Value = account;
            cmd.Parameters.Add("@UserHash", SqlDbType.VarChar, 0).Value = userHash;

            DataTable dt =  ExecuteScalarCmd3(cmd);

            object[] bool_User = new object[2];

            if (dt.Rows.Count > 0)
            {
                User user = new User();
                user.username = dt.Rows[0]["Login_id"].ToString();
                user.pwd = dt.Rows[0]["UserHash"].ToString();
                bool_User[0] = true;
                bool_User[1] = user;
            }
            else {
                bool_User[0] = false;
            }

            return bool_User;
        }


        public static string GetRowNumber(int PageIndex, int PageSize)
        {
            if (PageIndex < 1 || PageSize < 1)
            {
                return " AND false";
            }

            int intRowStart = (PageIndex * PageSize) - PageSize;
            int intRowEnd = (PageIndex * PageSize) + 1;

            StringBuilder sbSql = new StringBuilder("");
            sbSql.AppendFormat(" AND RowSort > {0}", intRowStart);
            sbSql.AppendFormat(" AND RowSort < {0}", intRowEnd);
            return sbSql.ToString();
        }

    }




}