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

namespace VO{
/// <summary>
/// Customer 的摘要描述
/// </summary>
[Serializable]
public class Customer
{

    public int Serial;
    public string CustId;
    public string CustBirthDay ;
    public string CustGender ;
    public string CustName ;
    public string CustTelPhone ;
    public string CustMobile ;
    public string CustAddr;
    public string CustEmail ;
    public string CustGroup ;
    public int Height ;
    public int Weight ;
    public string BloodType ;
    public string Constellation ;
    public string JobTitle ;
    public int MonthIncome ;
    public string Contect ;
    public string Habbit ;
    public string Interest ;
    


	public Customer(){}

    public static Customer CustInfo(string CustID) {

        return DataAccessLayer.DataAccessHelper.getDataAccess().CustInfo(CustID);
    }

    public static DataTable CustList(int pageindex, int pagesize, string CustId, string CustName, String CustTelPhone,
                                          string CustMobile,string CustAddress){


        return DataAccessLayer.DataAccessHelper.getDataAccess().CustList(pageindex,pagesize,CustId,CustName,CustTelPhone,
                                                                        CustMobile,CustAddress);
                               
    }

    


}



}