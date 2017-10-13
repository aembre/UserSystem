<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<style type="text/css">
#info
  {
  width:80%;
  border-collapse:collapse;
  }
#info td, #info th
  {
  border:1px solid black;
  }
.inputTd{
  text-align:center;
}
#info th{
	  font-size:1em;
}
</style>
<script src="<%=basePath%>resource/js/jquery.js"></script>
<script type="text/javascript">
	
		var arr = [];
		function doPrompt(){
			if($.trim($("#partNumber").val())=="" && $.trim($("#partName").val())==""){
				alert("请输入件号或件名!");
				return;
			}
			$("#info").find("td").parent().remove();//添加前删除原先生成的行
			$("#prompt").text("查询中，请稍候..........");//设置提示
			
			
			$.post("<%=basePath%>/jl/withdrawalfeeding/bill_main/billMain.do?method=isExist",
					{
						partNumber:$("#partNumber").val(),
						partName:$("#partName").val(),
						pageNo:$("#pageNo").val(),
						pageSize:$.trim($("#pageSize").val())
					},
					function(data,status){
						$("#partName").val("");
						if(data==="false"){
							alert("没有查询到指定数据！");
						}else{
							var resultData = eval("(" + data + ")");
							for(var i=0;i<resultData.result.length;i++){
								addRow(resultData.result[i]);
								arr[i]=resultData.result[i];
							}
						}
						$("#prompt").text("");//清除提示
					});
			
		}
		//添加行
		function addRow(data){
			var text="<tr>"+
						"<td class='inputTd'><input type='checkbox' class='part'/></td>"+
						"<td>"+data.pitem_id+"</td>"+
						"<td>"+data.pobject_name+"</td>"+
					"</tr>";  
			$("#info").append(text);
		}
	$(document).ready(function(){
		//全选全不选
		$("#total").click(function(){
			if($("#total").attr("checked")){
				$(".part").attr("checked","checked");
			}else{
				$(".part").attr("checked",false);
			}
		});
		$("#doSubmit").click(function(){
			doPrompt();
		});
		$("#confirm").click(function(){
			var result = [];//临时存储选定行的数据
			var trs = $(".part");
			for(var i=0;i<trs.length;i++){
				if(trs[i].checked){
					var rowIndex = trs[i].parentNode.parentNode.rowIndex;
					result.push(arr[rowIndex-2]);
				}
			}
			window.returnValue = result;
			window.close(); 
		});
		//控制上一页、下一页显示
		/* $("#firstPage").click(function(){
			$("#previousPage").hide();
		});
		$("#endPage").click(function(){
			$("#nextPage").hide();
		}); */
	});
</script>
<html:form action="/jl/withdrawalfeeding/bill_main/billMain.do">
<base target="_self">
<a id="reload" href="" style="display:none">reload</a> 
	<center>
		<table>
			<tr>
				<td>件号：</td>
				<td>
					<input type="text" id="partNumber"/>
				</td>
			</tr>
			<tr>
				<td>件名：</td>
				<td><input type="text" id="partName"></td>			
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="button" value="查询" id="doSubmit" />
					<input type="button" value="确认" id="confirm" />
				</td>
			</tr>
		</table>
		<span style="color:red" id="prompt"></span>
		<hr/>
		<table id="info">
			<tr>
				<th style="width:10%"><input type="checkbox" id="total" /></th>
				<th>件号</th>
				<th>件名</th>
			<tr/>
		</table>
		<!-- <div>
			<span style="float:left;">
				<span style="margin-left: 47px" id="firstPage">首页</span>
				<span id="previousPage">上一页</span>
				<span id="nextPage">下一页</span>
				<span id="endPage">尾页</span>
			</span>
			<span style="float:right;">
				<span style="margin-right: 20px">共条</span>
				<span style="margin-right: 20px">第<input type="text" id="pageNo" name="pageNo" readonly="readonly" value="1" style="width: 15px"/>页</span>
				<span style="margin-right: 50px">每页<input type="text" id="pageSize" name="pageSize" value="10" style="width: 20px"/>条</span>
			</span>
		</div> -->
	</center>
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp"%>