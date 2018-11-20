$.ajaxSetup({
    cache: false
});
$(function() {
    diyserverLoad();
	
    $(".CloudRightMainSelectMenu>ul>li").click(function() {
        var clk = $(this).index();
        if (clk == 0) {
            $(this).removeClass("Tab_tx_b").addClass("Tab_tx_a");
            $(".CloudRightMainSelectMenu>ul>li:eq(1)").removeClass("Tab_tc_b").addClass("Tab_tc_a");
            $("#CloudList001").show();
            $("#CloudList002").hide()
        } else {
            $(this).removeClass("Tab_tc_a").addClass("Tab_tc_b");
            $(".CloudRightMainSelectMenu>ul>li:eq(0)").removeClass("Tab_tx_a").addClass("Tab_tx_b");
            $("#CloudList001").hide();
            $("#CloudList002").show()
        }
    });
    LoadPjCount();
    $(".nav_unitive>ul>li").click(function() {
        var index = $(this).index();
        var infoDiv = $("#chy_box_" + index);
        $(this).addClass("active").siblings().removeClass("active");
        infoDiv.siblings("div[id*='chy_box_']").hide();
        infoDiv.show();
        if (index == 3) {
            if (infoDiv.html().indexOf("waitingDiv") > -1) {
                LoadGuestTalk(1)
            }
        }
    });
    $('.CloudRighticos ul li').mouseover(function() {
        var i = 0;
        $(".CloudRighticos ul li").each(function() {
            $(this).find("a").attr('class', "cloudicon" + (i + 1));
            i++
        });
        var nowindex = $(this).index();
        $(this).find("a").attr('class', "cloudiconh" + (nowindex));
        $(".descriptionall").removeClass("show");
        var desall = $(".des" + nowindex);
        desall.addClass("show")
    });
    $('#tuijian_msg input').hover(function() {
        var inuptindex = $(this).index();
        $(".fitall").removeClass("show");
        var fitall = $(".fit" + inuptindex);
        fitall.addClass("show")
    },
    function() {
        $(".fitall").removeClass("show")
    })
});
function dobuycount(){
	var buycountObj=$("select[name='buycount']");
	if(buycountObj.get(0)){
		buycountObj.msDropdown({
			visibleRows: 10
		}).data("dd");
		buycountObj.change(function(){
			getprice()
		});
	}
}
function diyserverLoad() {
    setrenewtime();
	if(useripmsg!="电信"){
		 var thisroomObj=$("input[name='room'][value='39']:radio");
		 if(thisroomObj.get(0)){
		  thisroomObj.prop("checked",true);
		 }
	 }
    tuijian();
    $("select[name='CHOICE_OS']").msDropdown({
        visibleRows: 15
    }).data("dd");
    $("input[name='room']:radio").click(function() {
	  if($(this).val()==40)
		{
			if (!confirm("提示：该机房对内容管控严!\n需要实名认证，请点机房名称阅读相关要求。确认选择该机房吗？"))
				{
			    return false;
		       }
	  }
	
	  if($("input[name='flux']:range").val()==0 && ($(this).val()==36 || $(this).val()==41)){
			alert("该机房带宽必须大于0M");
			return false;
		}
		setDisktype()
        getprice()
    });
    $("input[name='servicetype']:radio").click(function() {
        getprice()
    });
    $("input[name='PayMethod']:radio").click(function() {
        setrenewtime();
        getprice()
    });
	$("input[name='disktype']:radio").click(function(){
	 setDisktype()
	 getprice();
		})
	dobuycount();
    $("input[name='subbtton']:button,input[name='testbtton']:button").click(function() {
        var btnName = $(this).attr("name");
        var isPaytest = btnName == "testbtton" ? true: false;

          //  alert("弹性云主机正在根据前段时间的试用反馈进行升级优化，暂停试用，预计7月1日正式上线，敬请关注，谢谢！");
          //  return false
        var select_cpu_i = $("input[name='cpu']:range").val();
        var s_os = $("select[name='CHOICE_OS'] option:selected").val();
        var select_ram_i = $("input[name='ram']:range").val();
        var select_data = $("input[name='data']:range").val();
        var select_flux = $("input[name='flux']:range").val();
		var select_room=$("input[name='room']:radio:checked").val();
		var select_buycount=$()

		
        if (s_os == "") {
            alert("请选择要安装的操作系统！");
            $("select[name='CHOICE_OS']").focus();
            return false
        }
        switch (s_os) {
        case "win":
        case "win_clean":
        case "win_64":
            if (select_ram_i < 2) {
                alert("提示：您选择的操作系统最少需要1G内存！请增加内存或更换为其他操作系统！");
                return false
            }
            break;
        case "win_2005":
        case "win_2008":
            if (select_ram_i < 3) {
                alert("提示：您选择的操作系统最少需要2G内存！请增加内存或更换为其他操作系统！");
                return false
            }
            break;
        case "win_2008_64":
        case "win_2012_clean":
            if (select_ram_i < 4) {
                alert("提示：您选择的操作系统最少需要3G内存！请增加内存或更换为其他操作系统！");
                return false
            }
            break
        }
        if (isPaytest) {
			if(select_cpu_i>3 && select_room!=41){
				alert("提示：试用主机最大允许4核CPU");
                return false
			}
			
            if (select_ram_i > 4) {
                alert("提示：试用主机最大允许3G内存");
                return false
            }
			
			
            if (select_data > 200) {
                alert("提示：试用主机最大允许200G硬盘");
                return false
            }
            if (select_flux > 10) {
                alert("提示：试用主机最大允许10M带宽");
                return false
            }
        }
		
    if (select_flux==0 && (select_room==36 || select_room==41))
    {
				alert("提示:您选择的是挂机专用主机或亚洲数据中心带宽必须大于0M");
				return false;
    }

	if(select_room==41 && select_cpu_i<0){
				alert("提示:您选择的是挂机专用主机,CPU核心不能小于1核");
				return false;
		}
		if(select_room!=41 && select_cpu_i>=5 && select_flux<=2){
			if(!confirm("提醒：如果您是用于挖矿等CPU密集型应用，请选择线路为\"挂机专用主机\"，其他线路不允许长时间CPU高负载占用。\n点\"确认\"继续提交，点\"取消\"返回修改配置。")){
				return false;
			}
		}	

        if ($("input[name='agreement']:checkbox").prop("checked")) {
            $("input[name='paytype']:hidden").val(isPaytest ? 1 : 0);
            setReboxBody()
        } else {
            alert("您还没有同意主机租用协议")
        }
    })
}
function putsubmit() {
 
		if($("input[name='Company']").val()!="" && $("input[name='Company']").val().length>60 ){
		  alert("企业或个人名称限60个字符以内!")
		  $("input[name='Company']").focus();
		  return false
		}
		 if($("input[name='Name']").val()!=""  && $("input[name='Name']").val().length>12){
		  alert("联系人限制12个字符以内!")
		  $("input[name='Name']").focus();
		  return false
		}
 
	 if($("input[name='trade']").val()!="" &&  $("input[name='trade']").val().length>32)
	    {
		  alert("证件号为空或大于32位!")
		  $("input[name='trade']").focus();
		  return false
		}
 
    var reg=/\d{3}-?\d{8}|\d{4}-?\d{7}|1[0-9]{10}/
	 if(!reg.test($("input[name='Telephone']").val()) && $("input[name='Telephone']").val()!=""){
		  alert("请输入正确联系电话")
		  $("input[name='Telephone']").focus();
		  return false
		}
   
    var reg=/\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/
	 if(!reg.test($("input[name='Email']").val())){
		  alert("请输入正确Email")
		  $("input[name='Email']").focus();
		  return false
		}

       var reg=/^1[\d]{10}/
	 if(!reg.test($("input[name='mobile']").val())){
		  alert("请输入正确手机号码")
		  $("input[name='mobile']").focus();
		  return false
		}
     
//		 if($("input[name='Address']").val()!="" &&  $("input[name='Address']").val().length>60){
//		  alert("联系地址不正确,限60字符以内!")
//		  $("input[name='Address']").focus();
//		  return false
//		 }

 

	  var reg=/[\d]{6}/
	  if(!reg.test($("input[name='zipcode']").val()) && $("input[name='zipcode']").val()!=""){
		  alert("请输入正确邮政编码")
		  $("input[name='zipcode']").focus();
		  return false
		}
		var reg=/^[\d]{5,12}$/
	  if(!reg.test($("input[name='qq']").val()) && $("input[name='qq']").val()!=""){
		  alert("请输入正确qq号码")
		  $("input[name='qq']").focus();
		  return false
		}
//	return false
    $("input[name='act']:hidden").val("buysub");
    $("form[name='buyform']").submit();
    $(this).slideUp(0);
    $("#loadsubinfo").slideDown(0)
}
function tuijian() {
    var tjArr = [{
        title: "入门型",
        content: {
            cpu: 2,
            ram: 2,
            data: 60,
            flux: 2
        }
    },
    {
        title: "标准型",
        content: {
            cpu: 2,
            ram: 3,
            data: 80,
            flux: 3
        }
    },
    {
        title: "商务型",
        content: {
            cpu: 3,
            ram: 5,
            data: 100,
            flux: 4
        }
    },
    {
        title: "舒适型",
        content: {
            cpu: 3,
            ram: 5,
            data: 200,
            flux: 5
        }
    },
    {
        title: "企业型",
        content: {
            cpu: 4,
            ram: 7,
            data: 300,
            flux: 8
        }
    },
    {
        title: "豪华型",
        content: {
            cpu: 5,
            ram: 8,
            data: 500,
            flux: 10
        }
    }];
    $("#tuijian_msg").empty();
    var buttonstr = "";
    $.each(tjArr,
    function(i, n) {
        $("#tuijian_msg").append("<input type=\"button\" name=\"tuijian_btn_" + i + "\" value=\"" + n.title + "\" class=\"btn_page_\" style=\"margin-top:3px;\" />&nbsp;&nbsp;");
        var thisbutton = $("input[name='tuijian_btn_" + i + "']");
        thisbutton.click(function() {
            dotuijians(thisbutton, n.content);
            inishow()
        });
        if (i == 1) {
            dotuijians(thisbutton, n.content);
            inishow()
        }
    })
}
function setbuttonrangeval(data, flux) {
    $("#data_range").html("<input type=\"range\" name=\"data\" value=\""+data+"\" min=\"50\" max=\"1000\" step=\"10\" /><div style=\"float:left;display:inline;margin-top:7px\">GB</div>");
   // $("input[name='data']:range").val(data);
    $("#flux_range").html("<input type=\"range\" name=\"flux\" min=\"0\" value=\""+flux+"\" max=\"200\" step=\"1\"  /><div style=\"float:left;display:inline;margin-top:7px\">Mbps</div>");
   // $("input[name='flux']:range").val(flux);

    var objs = $("input[name='flux']:range,input[name='data']:range");
    objs.rangeinput({
        progress: true,
        change: function(e, i) {
            getprice();
			fluxtixingmsg(i);
            $(".btn_page_").removeClass("btn_page_1")
        }
    });
	fluxtixingmsg(flux);
    $("#flux_range .slider,#data_range .slider").before("<a class='slider-leftbutton'></a>");
    $("#flux_range .slider,#data_range .slider").after("<a class='slider-rightbutton'></a>");
    $(".range").blur(function() {
        getprice()
    });
    var fluxval = $.trim($("input[name='flux']:range").val());
    fluxval = isNaN(fluxval) ? 1 : Number(fluxval);
    $("#data_range .slider-leftbutton").click(function() {
        var dataval = $.trim($("input[name='data']:range").val());
        dataval = isNaN(dataval) ? 50 : Number(dataval);
        var fluxval = $.trim($("input[name='flux']:range").val());
        fluxval = isNaN(fluxval) ? 1 : Number(fluxval);
        setbuttonrangeval(dataval - 10, fluxval);
        getprice()
    });
    $("#data_range .slider-rightbutton").click(function() {
        var dataval = $.trim($("input[name='data']:range").val());
        dataval = isNaN(dataval) ? 50 : Number(dataval);
        var fluxval = $.trim($("input[name='flux']:range").val());
        fluxval = isNaN(fluxval) ? 1 : Number(fluxval);
        setbuttonrangeval(dataval + 10, fluxval);
        getprice()
    });
    $("#flux_range .slider-leftbutton").click(function() {
        var dataval = $.trim($("input[name='data']:range").val());
        dataval = isNaN(dataval) ? 50 : Number(dataval);
        var fluxval = $.trim($("input[name='flux']:range").val());
        fluxval = isNaN(fluxval) ? 1 : Number(fluxval);
        setbuttonrangeval(dataval, fluxval - 1);
        getprice()
    });
    $("#flux_range .slider-rightbutton").click(function() {
        var dataval = $.trim($("input[name='data']:range").val());
        dataval = isNaN(dataval) ? 50 : Number(dataval);
        var fluxval = $.trim($("input[name='flux']:range").val());
        fluxval = isNaN(fluxval) ? 1 : Number(fluxval);
        setbuttonrangeval(dataval, fluxval + 1);
        getprice()
    })
}
function dotuijians(v, content) {
    $("input[name^='tuijian_btn_']").removeClass();
    $("input[name^='tuijian_btn_']").addClass("btn_page_");
    $("#cpu_range").html("<input type=\"range\" name=\"cpu\" min=\"1\" value=\""+content.cpu+"\" max=\"" + cpucount + "\" step=\"1\" />");
    //$("input[name='cpu']:range").val(content.cpu);
    $("#ram_range").html("<input type=\"range\" name=\"ram\" value=\""+content.ram+"\" min=\"1\" max=\"" + ramcount + "\" step=\"1\"/>");
    //$("input[name='ram']:range").val(content.ram);
    //var objs = $("input[name='cpu']:range,input[name='ram']:range");
    $("input[name='cpu']:range").rangeinput({
        progress: true,
        change: function(e, i) {
				if(i<2){
					window.clearTimeout(cpu_ttt);
					$("#cpu_datatishi").fadeIn("slow");		
					cpu_ttt=window.setTimeout(function(){$("#cpu_datatishi").fadeOut("slow");},10000);
				}else{
					$("#cpu_datatishi").fadeOut("slow");
				}
			getprice();
            $(".btn_page_").removeClass("btn_page_1");
            inishow()
        }
    });
	 $("input[name='ram']:range").rangeinput({
        progress: true,
        change: function(e, i) {
				if(i<2){
					window.clearTimeout(ram_ttt);
					$("#ram_datatishi").fadeIn("slow");		
					ram_ttt=window.setTimeout(function(){$("#ram_datatishi").fadeOut("slow");},10000);
				}else{
					$("#ram_datatishi").fadeOut("slow");
				}			
			getprice();
            $(".btn_page_").removeClass("btn_page_1");
            inishow()
        }
    });
    setbuttonrangeval(content.data, content.flux);
    $(v).addClass("btn_page_1");
    getprice()
}
function inishow() {
    var cpuindex = $("input[name='cpu']:range").val() - 1;
    var ramindex = $("input[name='ram']:range").val() - 1;
    $("input[name='cpu']:range").parent().next().children().css({
        "font-weight": "normal",
        "color": "#333"
    });
    $("input[name='cpu']:range").parent().next().children().eq(cpuindex).css({
        "font-weight": "bold",
        "color": "#069"
    });
    $("input[name='ram']:range").parent().next().children().css({
        "font-weight": "normal",
        "color": "#333"
    });
    $("input[name='ram']:range").parent().next().children().eq(ramindex).css({
        "font-weight": "bold",
        "color": "#069"
    })
}
var cpu_ttt; var ram_ttt; var room_ttt;
function getprice() {
	select_disktype=$("input:radio[name='disktype']:checked").val();
	if(userinfo.u_level>1)
	{
		$("#agentroom_datatishi").show(100)
	}
    var cpu = $("input[name='cpu']:range").val();
    var ram = $("input[name='ram']:range").val();
    var flux = $("input[name='flux']:range").val();
    var data = $("input[name='data']:range").val();
    var room = $("input[name='room']:radio:checked").val();
    var renewTime = $("select[name='renewTime']").val();
	var buycountObj=$("select[name='buycount'] option:selected");
	var buycount=buycountObj.get(0)?buycountObj.val():1;
    var PayMethod = $("input[name='PayMethod']:radio:checked").val();
    var servicetype = $("input[name='servicetype']:radio:checked").val();
 
 
 
var jgi=1
var roomid=0
var data_step=10
var month=0

//价格数组下标
switch(PayMethod){
 case "0":
	 jgi=1;
	 month=1
	 break
 case "1":
	 jgi=4;
	 month=12
	 break
 case "2":
 month=3
    jgi=2;
	break;
 case "3":
    jgi=3
	month=6
	break;
 default:  
  alert("支付方式错误！");
  return false;
  break;
}

 
 
// 计算
//获取cpu参数 cpu价格

cpu_t=diyconfig.cpu.split(";");
 c_t=cpu_t[cpu-1].split(":");
cpu_p=c_t[jgi]
if(room==41)
{
//	cpu_p=cpu_p*1.5
	}

//获取内存参数
var r_i=0
ram_t=diyconfig.ram.split(";"); 
r_t=ram_t[ram-1].split(":");
ram_p=r_t[jgi]




var f_i=0
var flux_p=0
flux_t=diyconfig.flux.split(";");
for (f_i;f_i<flux_t.length;f_i++)
{
f_t=flux_t[f_i].split(":");
	if(f_t[0]==room)
	{
		break;
	}
}

if (f_i==-1)
{
	alert('无效数据')
	return false;
}

f_t=flux_t[f_i].split(":");
roomid=f_t[0]
flux_p=f_t[jgi]
flux_minp=f_t[jgi+4];
flux_maxp=f_t[jgi+8]


if(flux<=5){
      flux_p=parseFloat(flux_minp)+parseFloat(flux_p)*flux
}else{
      flux_p=parseFloat(flux_minp)+parseFloat(flux_p)*5+parseFloat(flux_maxp)*(flux-5)
   }
   
 
 
//硬盘价格

var d_i=0
data_t=diyconfig.data.split(":");
data_step=data_t[0]
data_p=data_t[jgi]
//alert(data_p)
if(data>50){
data_p= (data-50)/data_step*data_p ;
if (data>2000)
{
	data_p=data_p*1.5
}
}else{
data_p=0
}


if(select_disktype=="ssd")
{
    data_p=data_p * 3
			if(month==12)
			{
			data_p=data_p+300}else
			{
				data_p=data_p+30*month}

}


allmonth=month*renewTime
s_p=0

if(servicetype.indexOf("铜牌服务")!=-1){s_p=48}
if(servicetype.indexOf("银牌服务")!=-1){s_p=98}
if(servicetype.indexOf("金牌服务")!=-1){s_p=188}




zj=((parseFloat(cpu_p)+parseFloat(ram_p)+parseFloat(flux_p)+parseFloat(data_p))*renewTime+parseFloat(allmonth*s_p))*buycount;


if(userinfo.diyfist==1){
 
	if(userinfo.userzk>1) 
	{
	 $("#pricelist").html("<span id=\"relprice\">"+Math.round(zj*userinfo.userzk)+"</span>");
	}
	else
	{
	 if(userinfo.userzk!=1)
	 {
	$("#pricelist").html("<span style=\"TEXT-DECORATION: line-through;color:#999;font-size:16px\">"+zj+"元</span><span id=\"relprice\">"+Math.round(zj*userinfo.userzk)+"</span>");
	}
	else
	{
	 $("#pricelist").html("<span id=\"relprice\">"+Math.round(zj*userinfo.userzk)+"</span>");
	}
	}

}else{
	if(PayMethod==0){
	$("#pricelist").html("<span style=\"TEXT-DECORATION: line-through;color:#999;font-size:16px\">"+zj+"元</span><span id=\"relprice\">"+Math.round(zj*userinfo.diyfist)+"</span>");}
	else{
		
			if(userinfo.userzk>1) 
	{
	 $("#pricelist").html("<span id=\"relprice\">"+Math.round(zj*userinfo.userzk)+"</span>");
	}
	else
	{
	 if(userinfo.userzk!=1)
	 {
	$("#pricelist").html("<span style=\"TEXT-DECORATION: line-through;color:#999;font-size:16px\">"+zj+"元</span><span id=\"relprice\">"+Math.round(zj*userinfo.userzk)+"</span>");
	}
	else
	{
	 $("#pricelist").html("<span id=\"relprice\">"+Math.round(zj*userinfo.userzk)+"</span>");
	}
	}
		
		}
	}
 
 $("#pricelist").css("color", "red"); 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 //
//    var info = "act=getprice&cpu=" + cpu + "&ram=" + ram + "&flux=" + flux + "&data=" + data + "&room=" + room + "&PayMethod=" + PayMethod + "&renewTime=" + renewTime + "&servicetype=" + escape(servicetype)+"&buycount="+buycount;
//    $("#pricelist").css("color", "#ccc");
//    $("input[name='subbtton']:button,input[name='testbtton']:button").attr("disabled", true);
//	//document.write(info)
//	
//    $.post(window.location.mappath, info,
//    function(msg) {
//        $("#pricelist").html(msg);
//        $("#pricelist").css("color", "red");
//        $("input[name='subbtton']:button,input[name='testbtton']:button").attr("disabled", false)
//    })
}
function setrenewtime() {
    $("#renewtime_msg").html("<select name=\"renewTime\" style=\"width:200px;\"></select>");
    var renewTimeObj = $("select[name='renewTime']");
    var payObj = $("input[name='PayMethod']:radio:checked");
    renewTimeObj.empty();
    var timelist = "";
    var dw = "";
    if (payObj.val() == "0") {
        timelist = "1";
		diy_msg_txt=""
        dw = "个月"
    } else if (payObj.val() == "1") {
        timelist = "1,2,3,4,5";
		diy_msg_txt="【买1年送3月】,【买2年送1年】,【买3年送2年】,,【买5年送3年】"
        dw = "年"
    } else if (payObj.val() == "2") {
        timelist = "1,2,3,4";
		diy_msg_txt=",【买6月送1月】,,【买1年送3月】"
        dw = "季度"
    } else if (payObj.val() == "3") {
        timelist = "1,2,3,4";
		diy_msg_txt="【买6月送1月】,【买1年送3月】,,【买2年送1年】"
        dw = "个月"
    }
	temparraylist=diy_msg_txt.split(",")
    $.each(timelist.split(","),
    function(i, n) {
        var nn = n;
        if (payObj.val() == "3") nn = parseInt(n) * 6;
		
		
        renewTimeObj.append("<option value=\"" + $.trim(n) + "\">" + nn + dw +temparraylist[n-1]+"</option>")
    });
    renewTimeObj.change(function() {
        getprice()
    });
    getpreday()
}
function getpreday() {
    var payObj = $("input[name='PayMethod']:radio:checked");
    var renewTimeObj = $("select[name='renewTime'] option");
    var renewTime = "";
    var preyear = 0;
    var nndw = "";
    $.each(renewTimeObj,
    function(i, n) {
        renewTime += $(n).val() + ","
    });
   
        $("select[name='renewTime']").msDropdown()
 
}
function LoadPjCount() {
    var info = "act=GetPingCount&random=" + Math.round(Math.random() * 10000);
    var ajaxurlstr = "default.asp";
    $.ajax({
        type: "POST",
        url: ajaxurlstr,
        data: info,
        datatype: "json",
        timeout: 30000,
        error: function(XmlHttpRequest, textStatus, errorThrown) {
            $("#pjCount").html("(0)")
        },
        success: function(xml) {
            $("#pjCount").html(xml)
        }
    })
}
function LoadGuestTalk(page) {
    var info = "act=LoadGuestTalk&PageNo=" + escape(page) + "&random=" + Math.round(Math.random() * 10000);
    var ajaxurlstr = "default.asp";
    $.ajax({
        type: "POST",
        url: ajaxurlstr,
        data: info,
        datatype: "json",
        timeout: 30000,
        error: function(XmlHttpRequest, textStatus, errorThrown) {
            $("#chy_box_3").html("载入错误,请刷新页面重试.")
        },
        success: function(xml) {
            $("#chy_box_3").html(xml)
        }
    })
}
function setUrlVal(objU, Kname, Kval) {
    var url = objU.href;
    var ss = "/\\b" + Kname + "=[^&=]+/";
    var oCheck = eval(ss);
    if (oCheck.test(url)) {
        url = url.replace(oCheck, Kname + "=" + escape(Kval))
    } else {
        url += "&" + Kname + "=" + escape(Kval)
    }
    objU.href = url;
    LoadSerBand(objU.id, Kval)
}
function LoadSerBand(objUid, Kval) {
    var serverRoom = Kval;
    var dk_vps_name = objUid + "_flux";
    var ip_vps_name = objUid + "_ip";
    $.ajax({
        type: "POST",
        url: "default.asp",
        cache: false,
        data: "act=ServBand&proid=" + escape(objUid) + "&serverRoom=" + escape(serverRoom),
        error: function(a, b, c) {},
        success: function(msg) {
            spmsg = msg.split("|");
            dkmsg = spmsg[0];
            ipmsg = spmsg[1];
            $("#" + dk_vps_name).html(dkmsg);
            $("#" + ip_vps_name).html(ipmsg)
        }
    })
}
function DoRoomPriceSelect(vps_type, k) {
    objTab = document.getElementById("vps_Big_Room_" + vps_type);
    div_list = objTab.getElementsByTagName("div");
    objTab = $("#vps_Big_Room_" + vps_type);
    for (i = 1; i <= div_list.length - 1; i++) {
        divObj = document.getElementById("vpsromprice_" + vps_type + "_" + i);
        radioOBJ = document.getElementById("radio_" + vps_type + "_" + i);
        if (i != k) {
            divObj.style.display = "none";
            radioOBJ.checked = false
        } else {
            radioOBJ.checked = true;
            divObj.style.display = ""
        }
    }
}
function seetitle(v, f, w, h) {
    if (w == "") {
        w = 200
    }
    if (h == "") {
        h = 100
    }
    doouttitlemsg(v, "<span style=\"color:#000\">" + f + "</span>", w, h, 1)
}
function closetitlebox() {
    $("#titletext").html("");
    $("#titlemsg").css("display", "none")
}
function setReboxBody() {
    var jsonArray = {
        "CPU": "cpu",
        "内存": "ram",
        "硬盘": "data",
        "带宽": "flux",
        "操作系统": "CHOICE_OS",
        "线路": "room",
        "服务标准": "servicetype",
        "付费方式": "PayMethod",
        "购买时长": "renewTime",
		"购买数量": "buycount"
    };
    var isPaytest = $("input[name='paytype']:hidden").val() == 1 ? true: false;
    $("#rebox").empty();
	
	//公司名称
	$("#rebox").append("<dd class=\"clearfix\"><label>公司名称：</label><label class=\"msg\"><input name=\"Company\" type=\"text\"\ value=\""+userinfo.u_company+"\" /></label>")
	$("#rebox").append("<dd class=\"clearfix\"><label>联系人：</label><label class=\"msg\"><input name=\"Name\" type=\"text\"\ value=\""+userinfo.u_namecn+"\" /></label>")
	$("#rebox").append("<dd class=\"clearfix\"><label>证件号：</label><label class=\"msg\"><input name=\"trade\" type=\"text\"\ value=\""+userinfo.u_trade+"\" /></label>")
	$("#rebox").append("<dd class=\"clearfix\"><label>联系电话：</label><label class=\"msg\"><input name=\"Telephone\" type=\"text\"\ value=\""+userinfo.u_telphone+"\" /></label>")
	$("#rebox").append("<dd class=\"clearfix\"><label>Email(<font color=red>*</font>)：</label><label class=\"msg\"><input name=\"Email\" type=\"text\"\ value=\""+userinfo.u_email+"\" /></label>")
		$("#rebox").append("<dd class=\"clearfix\"><label>手机(<font color=red>*</font>)：</label><label class=\"msg\"><input name=\"mobile\" type=\"text\"\ value=\""+userinfo.u_mobile+"\" /></label>")
//		$("#rebox").append("<dd class=\"clearfix\"><label>地址：</label><label class=\"msg\"><input name=\"Address\" type=\"text\"\ value=\""+userinfo.u_address+"\" /></label>")
		$("#rebox").append("<dd class=\"clearfix\"><label>邮编：</label><label class=\"msg\"><input name=\"zipcode\" type=\"text\"\ value=\""+userinfo.u_zipcode+"\" /></label>")
			$("#rebox").append("<dd class=\"clearfix\"><label>联系QQ：</label><label class=\"msg\"><input name=\"qq\" type=\"text\"\ value=\""+userinfo.qq_msg+"\" /></label>")
	
    $.each(jsonArray,
    function(name, value) {
        var thisval;
        if (value == "room" || value == "servicetype") {
			thisval = $("input[name='" + value + "']:radio:checked").next("a").html()
        } else if (value == "PayMethod") {
            thisval = $("input[name='" + value + "']:radio:checked").next("span").html();
            if (isPaytest) {
                thisval = "<span style=\"color:#06c;font-size:14px;background-color:#FFC\">试用4小时</span>"
            }
        } else if (value == "CHOICE_OS" || value == "renewTime" || value=="buycount") {
            thisval = $("select[name='" + value + "'] option:selected").text();
            if (isPaytest && value == "renewTime") {
                thisval = "<span style=\"color:#06c;font-size:14px;background-color:#FFC\">4小时后系统将自动删除</span>"
            }
        } else if (value == "cpu") {
            var diveq = $("input[name='" + value + "']").val();
            thisval = $("#cpuvalue>div:eq(" + (Number(diveq) - 1) + ")").text()
        } else if (value == "ram") {
            var diveq = $("input[name='" + value + "']").val();
            thisval = $("#ramvalue>div:eq(" + (Number(diveq) - 1) + ")").text()
        } else if (value == "data") {
            thisval = $("input[name='" + value + "']").val() + "G"
        } else if (value == "flux") {
            thisval = $("input[name='" + value + "']").val() + "M"
        }
        if (thisval != "") {
            $("#rebox").append("<dd class=\"clearfix\"><label>" + name + "：</label><label class=\"msg\">" + thisval + "</label></dd>")
        }
    });
	var buycountObj=$("select[name='buycount'] option:selected");
	var buycount=buycountObj.get(0)?buycountObj.val():1;
    var paytesttishi = isPaytest ? "<br><span class=\"redColor\">试用须知：</span><br>试用收费5元，必须先通过邮箱和手机认证。<br>每个直接用户最多允许试用5次，代理商不限。<br>试用时间为2小时，2小时后自动删除，转正前请勿放置正式数据。<br>试用主机仅做功能测试和速度测试用，不允许提交白名单。": "";
    $("#rebox").append("<dd class=\"clearfix\" style=\"border:none\"><label>费用合计：</label><label class=\"msg\" id=\"needprice\" style=\"color:red; font-weight:bold; font-size:16px\"></label>							</dd><dd class=\"clearfix\" style=\"border:none\"> <div><img src=\"/images/Cloudhost/alert.jpg\"></div></dd><dd class=\"subbottom clearfix\" style='border:none;padding-left:200px;'><input type=\"button\" name=\"submitbutton_re\" class=\"resubmit\" value=\" 确认提交 \"  /><input type=\"button\" name=\"submitbutton_back\" class=\"backsubmit\" value=\" 返回修改 \"   /></dd>");
    var needprice_msg = isPaytest ? paytestprice * buycount + "元": $("#relprice").html() + "元";
    $("#needprice").html(needprice_msg);
    $("#putbox").fadeOut("fast",
    function() {
        $(".qrlayout").fadeIn("fast");
        $(document).scrollTop(750)
    });
    $("input[name='submitbutton_back']:button").click(function() {
        $(".qrlayout").fadeOut("fast",
        function() {
            $("#putbox").fadeIn("fast")
        })
    });
    $("input[name='submitbutton_re']:button").click(function() {
        putsubmit()
    })
}

function dolocaldisktype(){
	if($("input[name='disktype'][value='local']:radio:checked").get(0)){
		alert("推荐选择更稳定的分布式存储，若确需使用磁盘阵列存储的，请先选择分布式存储开通，开通成功后再到控制面板中切换存储模式。");
		$("input[name='disktype'][value='ebs']:radio").prop("checked",true);
	}
}



function setDisktype(){
	var room=$("input[name='room']:radio:checked").val();
	var disktypeval=$("input[name='disktype']:radio:checked").val();
	if(disktypeval=="ssd"){
		//if(room==37 || room==38){
			if(!confirm("SSD固态硬盘模式有极高的随机IO性能，价格较贵，适合于大型SQlserver数据库或其他对IO性能要求较高的场景。此种模式存在单点故障风险，请根据您的业务需求使用双机热备或负载均衡等方案进行容灾备份。\n确认选择SSD存储吗？")){
				$("input[name='disktype'][value='ebs']:radio").prop("checked",true);
			}else{
				 getprice();	
			}
	//	}else{
	//		  $("input[name='disktype'][value='ebs']:radio").prop("checked",true);
	//		  getprice();	
	//	}
	}
}
var flux_ttt;

function fluxtixingmsg(flux){
	
	if(flux<=0){
		 window.clearTimeout(flux_ttt);
		$("#flux_datatishi").fadeIn("slow");		
		flux_ttt=window.setTimeout(function(){$("#flux_datatishi").fadeOut("slow");},10000);
	}else{
		$("#flux_datatishi").fadeOut("slow");
	}
}