<%@include file='authcheck.jsp' %>
<%@page import='util.encrypt'%>
 
<%
//test
//test2
%>
  
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>  
<html>
    <head>
        <link rel="stylesheet" href="style.css" type="text/css"/>
        <link rel="stylesheet" href="../style.css" type="text/css"/>


        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script>
$(window).load(function(){

var countISP = 2;
var countFirewall = 2;
var countCore = 0;
var countFirewallInfo = 0; 

  // ISP Add/Remove  
        $('.addISP').click(function() {

        $('.blockISP:last').before('<div class="blockISP"> <table> <tr><td> ISP'+countISP+' Name: </td><td><input type="text" class="input" name="ISP'+countISP+'"/></td></tr><tr><td> Firewall Port: </td><td><input type="text" class="input"/> </td></tr></table><span class="removeISP"></span><br></div>');
        countISP++;
        });

        $('.isp').on('click','.removeISP',function() {
 	$(this).parent().remove();
        countISP--;
        });

// Firewall Add/Remove

      $('.addFirewall').click(function() {

        $('.blockFirewall:last').before('<div class="blockFirewall"> <table> <tr><td> Firewall'+countFirewall+' Name: </td><td><input type="text" class="input" name="Firewall'+countFirewall+'"/></td></tr><tr><td> Core Port: </td><td><input type="text" class="input"/> </td></tr></table><span class="removeFirewall"></span><br></div>');
        countFirewall++;
        });

        
        $('.firewall').on('click','.removeFirewall',function() {
 	$(this).parent().remove();
        countFirewall--;
        });

// Core Add/Remove

      $('.addCore').click(function() {

        $('.blockCore:last').before('<div class="blockCore"> <table> <tr><td> Core'+countCore+' Name: </td><td><input type="text" class="input" name="Core'+countCore+'"/></td></tr><tr><td> Access Switch Port: </td><td><input type="text" class="input"/> </td></tr></table><span class="removeCore"></span><br></div>');
        countCore++;
        });

        
        $('.core').on('click','.removeCore',function() {
 	$(this).parent().remove();
        countCore--;
        });

// .content-wrapper FirewallInfo

      $('.addFirewallInfo').click(function() {
         
        $('.firewallInfo:last').before('<div><input name="name" class="input" value='+countFirewallInfo+'><input name="name" class="input"><input name="name" class="input"><input name="name" class="input"><input name="name" class="input"><input name="name" class="input"><span class="removeFirewallInfo"></span></div>');
        countFirewallInfo++;
        });

        
        $('#content-wrapper ').on('click','.removeFirewallInfo',function() {
 	$(this).parent().remove();
        countFirewallInfo--;
        });

// .content-wrapper NetworkInfo

      $('.addNetworkInfo').click(function() {

        $('.networkInfo:last').before('<div><input name="name" class="input"><input name="name" class="input"><input name="name" class="input"><input name="name" class="input"><input name="name" class="input"><input name="name" class="input"><span class="removeNetworkInfo"></span></div>');
        countCore++;
        });

        
        $('#content-wrapper ').on('click','.removeNetworkInfo',function() {
 	$(this).parent().remove();
        countCore--;
        });




});
        </script>

        

        <title>Hello, <%=user %>!</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>

    <body>
        <div id="mainwrapper">
   <!-- Menu start -->     
        <%@include  file='menu.jsp' %>
   <!-- menu end -->
<!-- Content -->


<div id="content-wrapper">
   
    <%
 //Main select and assign all main variables 
        sqlSelect myMainSelect = new sqlSelect();
        int[] sitesId = myMainSelect.obtainSitesID(companyId);
        String [] sitesName = myMainSelect.obtainSitesName(companyId);
        int [] userAccess = myMainSelect.obtainUserAccess(user);
        
        

//siteName loop starts
        for (int l=0; l < sitesId.length; l++)
        {
//classNames loop starts vpn,firewall,network,windows etc.
            for (int m=0; m<classNames.length; m++)
            {

            //check if any records in firewall tables for companyId and siteId is present, if yes display it
            if (myMainSelect.checkClassInfo(companyId, sitesId[l], classNames[m]) != 0 && userAccess[m] != 0)
            {
            //Get array[][] from firewall table
            String[][] classInfo = myMainSelect.obtainClassInfo(companyId, sitesId[l], classNames[m]);
            String[][] recordId = myMainSelect.obtainClassInfoAndId(companyId, sitesId[l], classNames[m]); 

    %>

<!-- Class Loop -->
<div class="mainHeadTop"><%=sitesName[l]%>: <%=classNames[m]%></div>
    
    <form name="firewall" method="post" action="updateFirewall">
<div class="displayTableMain">
        <div class="displayRowMain">
            <div class="displayCellMain"><input name="name" class="mainHeadSub" readonly="" value="IP"></div><div class="displayCellMain"><input name="name" class="mainHeadSub" readonly="" value="Name"></div><div class="displayCellMain"><input name="name" class="mainHeadSub" readonly="" value="Model/OS"></div><div class="displayCellMain"><input name="name" class="mainHeadSub" readonly="" value="Login"></div><div class="displayCellMain"><input name="name" class="mainHeadSub" readonly="" value="Password"></div><div class="displayCellMain"><input name="name" class="mainHeadSub" readonly="" value="URL"></div>
        </div>
        

        <%  
            
            
            for (int i = 0; i < classInfo[0].length; i++)
            {%><div class="displayRowMain"><%
                for (int j=0; j< classInfo.length; j++)
                {
                    String display = classInfo[j][i];
                    if (j == 4) { display = encrypt.xor_decrypt(classInfo[j][i], "ic3t4l4ch4b1"); }
                    
                    %><div class="displayCellMain"><input name="name" class="input" readonly="" value="<%=display%>"></div><%
                }
                %><% if (userAccess[m] == 2) {%><a class="displayCell" href="updateInfo.jsp?siteId=<%=sitesId[l]%>&class=<%=classNames[m]%>&recordId=<%=recordId[6][i]%>">Edit </a><a class="displayCell" href="../deleteInfo?siteId=<%=sitesId[l]%>&class=<%=classNames[m]%>&recordId=<%=recordId[6][i]%>"><span class="removeNetworkInfo"></span> </a><%}%></div><%
            }
            if (userAccess[m] == 2) {%><a href="addInfo.jsp?siteId=<%=sitesId[l]%>&class=<%=classNames[m]%>"><span class="addNetworkInfo"></span><br><br></a> <%} %>
        
        
</div>
    </form>
<!-- Firewall/VPN site A ENDS -->
    <%
               }
            }

        }
//Main per site loop ends        
        %>
        
        
        
<!-- networkInfo site A

    <div style="background-color: #3a8ecf; color: white; font-weight: bold; height: 30px; padding-top: 10px; padding-left: 10px;"> Network Info: </div>
    
    <form name="network" method="post" action="updateNetwork">

        <div>
        <input name="name" class="mainHeadSub" readonly="" value="IP"><input name="name" class="mainHeadSub" readonly="" value="Name"><input name="name" class="mainHeadSub" readonly="" value="Model/OS"><input name="name" class="mainHeadSub" readonly="" value="Login"><input name="name" class="mainHeadSub" readonly="" value="Password"><input name="name" class="mainHeadSub" readonly="" value="URL">
        </div>
        <div><input name="name" class="input"><input name="name" class="input"><input name="name" class="input"><input name="name" class="input"><input name="name" class="input"><input name="name" class="input"></div>
       
        <div class="networkInfo">
            
        </div>
        <span class="addNetworkInfo"></span><br><br>
    </form>
<!-- Firewall/VPN site A ENDS -->
<!--
<%=user %>
<%=userUuid %>

-->
<!-- content-wrapper div ends -->
</div>

<!-- CONTENT END -->
           
        </div>
    </body>
</html>
