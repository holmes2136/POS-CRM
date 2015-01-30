<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>登入</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
 <link href="css/bootstrap.css" rel="stylesheet">
 <link href="css/bootstrap-responsive.min.css" rel="stylesheet">
    <style type="text/css">
      body {
        padding-top: 40px;
        padding-bottom: 40px;
        background-color: #f5f5f5;
      }

      .form-signin {
        max-width: 300px;
        padding: 19px 29px 29px;
        margin: 0 auto 20px;
        background-color: #fff;
        border: 1px solid #e5e5e5;
        -webkit-border-radius: 5px;
           -moz-border-radius: 5px;
                border-radius: 5px;
        -webkit-box-shadow: 0 1px 2px rgba(0,0,0,.05);
           -moz-box-shadow: 0 1px 2px rgba(0,0,0,.05);
                box-shadow: 0 1px 2px rgba(0,0,0,.05);
      }
      .form-signin .form-signin-heading,
      .form-signin .checkbox {
        margin-bottom: 10px;
      }
      .form-signin input[type="text"],
      .form-signin input[type="password"] {
        font-size: 16px;
        height: auto;
        margin-bottom: 15px;
        padding: 7px 9px;
      }

    </style>

</head>
<body>
<div class="container">

    <form id="form1" runat="server" class="form-signin">
            <h2 class="form-signin-heading">Please sign in</h2>
            <asp:TextBox runat="server" ID="txt_Account"  class="input-block-level" placeholder="Account" />
            <asp:TextBox runat="server" ID="txt_Pwd"  class="input-block-level" placeholder="Password" />
            <asp:Button runat="server" ID="btn_SignIn" 
                class="btn btn-large btn-primary" Text="Sign in"
                OnClick="btn_SignIn_OnClick" />
    </form>
    </div>
    <!-- /container -->
</body>
</html>
