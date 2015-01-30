using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Text;
using System.Security.Cryptography;


namespace Util
{
    /// <summary>
    /// Security 的摘要描述
    /// </summary>
    public class Security
    {
        public Security()
        {
           
        }

        public static string HashPassword(string sPASSWORD)
        {
            UTF8Encoding utf8 = new UTF8Encoding();
            byte[] aby = utf8.GetBytes(sPASSWORD);
            string result;
            using (MD5CryptoServiceProvider md5 = new MD5CryptoServiceProvider())
            {
                byte[] binMD5 = md5.ComputeHash(aby);
                result = HexEncode(binMD5);
            }
            return result;
        }


        public static string HexEncode(byte[] aby)
        {
            string hex = "0123456789abcdef";
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < aby.Length; i++)
            {
                sb.Append(hex[(aby[i] & 240) >> 4]);
                sb.Append(hex[(int)(aby[i] & 15)]);
            }
            return sb.ToString();
        }


    }

}
