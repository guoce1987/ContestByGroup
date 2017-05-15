$(function() {
	$("#datepicker").datepicker({
		language : 'zh-CN',
		autoclose : true,
		format : "yyyy-mm",
		minViewMode : 1,
		todayBtn : true
	});
	var d = new Date();
	$("#datepicker").datepicker("setDate", d.getFullYear() + "-" + (d.getMonth()+1));// 设置
	
	$("#datepicker").datepicker().on("changeMonth", function(e) {
		//$("ul.nav.nav-list li.active a").click(); 容易造成冒泡事件
		var fnStr = $("ul.nav.nav-list li.active a").attr('onclick')
		eval(fnStr);
    });
	$("#dpaddon").on("click", function(){
		$("#datepicker").datepicker("show");
	});
	$("ul.nav.nav-list>li:nth-child(1) a").click();
	

	$(window).on('resize.jqGrid',function() {
		var $gridParent = $("#body");
		var $grid = $("#grid-table");
		$grid.jqGrid('setGridWidth',$gridParent.width());
		resizeGridWidth();
	});

	// resize on sidebar collapse/expand
	$(document).on('settings.ace.jqGrid', function(ev, event_name, collapsed) {
		if (event_name === 'sidebar_collapsed' || event_name === 'main_container_fixed') {
			// setTimeout is for webkit only to give time for DOM
			// changes and then redraw!!!
			var $gridParent = $("#body");
			var $grid = $("#grid-table");
			setTimeout(function() {
				$grid.jqGrid('setGridWidth',$gridParent.width());
				resizeGridWidth();
			}, 15);
		}
	});
	
	$("#ace-settings-add-container").on("click",function(){
		$.cookie("continer",$("#ace-settings-add-container").is(':checked'),{
			expires : 7, path: '/' 
		});
	});
	
	$('.nav.nav-list > li:has(li)').on('click', function(e){
		//$(this).find('li:first a').click(); //这种写法会造成死循环
		var fnStr = $(this).find('li:first a').attr('onclick');
		$liClicked = $(this);
		//console.log($liClicked.attr('class'));
		setTimeout(function() {
			if("open" == $liClicked.attr('class')) eval(fnStr);
		}, 300);
	});
	
	var locat = (window.location+'').split('/'); 
	
	$.ajax({
		type: "POST",
		url: '/ContestByGroup/head/getUname.do?tm='+new Date().getTime(),
    	data: encodeURI(""),
		dataType:'json',
		//beforeSend: validateData,
		cache: false,
		success: function(data){
			//alert(data.list.length);
			 $.each(data.list, function(i, list){
				 //登陆者资料
				 $("#user_info").html('<small>Welcome</small> '+list.NAME+'');
				 $("#username").val(list.USERNAME);
			 });
		}
	});

});

function getYear(){
	var year = $("#datepicker").val().split("-")[0];
	return year;
}

function getMonth(){
	var month = $("#datepicker").val().split("-")[1];
	return month;
}

function resizeGridWidth(){
	var w2 = parseInt($('.ui-jqgrid-labels>th:eq(2)').css('width'))-3;
	$('.ui-jqgrid-lables>th:eq(2)').css('width',w2);
	$('#grid-table tr').find("td:eq(2)").each(function(){
	    $(this).css('width',w2);
	})
}

//获取当前表格的所有数据
function getJQAllData(grid) {
       var o = jQuery(grid);
       //获取当前显示的数据
       var rows = o.jqGrid('getRowData');
       var rowNum = o.jqGrid('getGridParam', 'rowNum'); //获取显示配置记录数量
       var total = o.jqGrid('getGridParam', 'records'); //获取查询得到的总记录数量
       //设置rowNum为总记录数量并且刷新jqGrid，使所有记录现出来调用getRowData方法才能获取到所有数据
       o.jqGrid('setGridParam', { rowNum: total }).trigger('reloadGrid'); 
       var rows = o.jqGrid('getRowData');  //此时获取表格所有匹配的
       o.jqGrid('setGridParam', { rowNum: rowNum }).trigger('reloadGrid'); //还原原来显示的记录数量
       return rows;
}

// js导出表的方法
var exportToFile = function(JSONData, Title, ShowLabel, fileName) {
    var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
    var CSV = '';
    if (ShowLabel) {
        var row = "";
        for (var index = 0; index < Title.length; index++) {
            row += Title[index] + ',';
            console.log("index:"+index+","+Title[index]);
        }
        row = row.slice(0, -1);
        CSV += row + '\r\n';
    }
    for (var i = 0; i < arrData.length; i++) {
        var row = "";
        for (var index in arrData[i]) {
            row += '"' + arrData[i][index] + '",';
        }
        row.slice(0, row.length - 1);
        if(i==arrData.length-1){
        	CSV += row;
        } else {
        	CSV += row + '\r\n';
        }
    }
    if (CSV == '') {
        alert("Invalid data");
        return;
    }
    var fileName = fileName;
    var uri = getDownloadUrl(CSV);
    var link = document.createElement("a");
    link.href = uri;
    link.style = "visibility:hidden";
    link.download = fileName + ".csv";
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
};

var getDownloadUrl = function(text) {
    var BOM = "\uFEFF";
    // Add BOM to text for open in excel correctly
    if (window.Blob && window.URL && window.URL.createObjectURL) {
      var csvData = new Blob([BOM + text], { type: 'text/csv' });
      return URL.createObjectURL(csvData);
    } else {
      return 'data:attachment/csv;charset=utf-8,' + BOM + encodeURIComponent(text);
    }
 };

function style_edit_form(form) {
	// enable datepicker on "sdate" field and switches for "stock" field
	form.find('input[name=sdate]').datepicker({
		format : 'yyyy-mm-dd',
		autoclose : true
	})

	form.find('input[name=stock]').addClass('ace ace-switch ace-switch-5')
			.after('<span class="lbl"></span>');
	// don't wrap inside a label element, the checkbox value won't be submitted
	// (POST'ed)
	// .addClass('ace ace-switch ace-switch-5').wrap('<label class="inline"
	// />').after('<span class="lbl"></span>');

	// update buttons classes
	var buttons = form.next().find('.EditButton .fm-button');
	buttons.addClass('btn btn-sm').find('[class*="-icon"]').hide();// ui-icon,
																	// s-icon
	buttons.eq(0).addClass('btn-primary').prepend(
			'<i class="ace-icon fa fa-check"></i>');
	buttons.eq(1).prepend('<i class="ace-icon fa fa-times"></i>')

	buttons = form.next().find('.navButton a');
	buttons.find('.ui-icon').hide();
	buttons.eq(0).append('<i class="ace-icon fa fa-chevron-left"></i>');
	buttons.eq(1).append('<i class="ace-icon fa fa-chevron-right"></i>');
}

function style_delete_form(form) {
	var buttons = form.next().find('.EditButton .fm-button');
	buttons.addClass('btn btn-sm btn-white btn-round').find('[class*="-icon"]')
			.hide();// ui-icon, s-icon
	buttons.eq(0).addClass('btn-danger').prepend(
			'<i class="ace-icon fa fa-trash-o"></i>');
	buttons.eq(1).addClass('btn-default').prepend(
			'<i class="ace-icon fa fa-times"></i>')
}

function style_search_filters(form) {
	form.find('.delete-rule').val('X');
	form.find('.add-rule').addClass('btn btn-xs btn-primary');
	form.find('.add-group').addClass('btn btn-xs btn-success');
	form.find('.delete-group').addClass('btn btn-xs btn-danger');
}
function style_search_form(form) {
	var dialog = form.closest('.ui-jqdialog');
	var buttons = dialog.find('.EditTable')
	buttons.find('.EditButton a[id*="_reset"]').addClass('btn btn-sm btn-info')
			.find('.ui-icon').attr('class', 'ace-icon fa fa-retweet');
	buttons.find('.EditButton a[id*="_query"]').addClass(
			'btn btn-sm btn-inverse').find('.ui-icon').attr('class',
			'ace-icon fa fa-comment-o');
	buttons.find('.EditButton a[id*="_search"]').addClass(
			'btn btn-sm btn-purple').find('.ui-icon').attr('class',
			'ace-icon fa fa-search');
}

function beforeDeleteCallback(e) {
	var form = $(e[0]);
	if (form.data('styled'))
		return false;

	form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner(
			'<div class="widget-header" />')
	style_delete_form(form);

	form.data('styled', true);
}

function beforeEditCallback(e) {
	var form = $(e[0]);
	form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner(
			'<div class="widget-header" />')
	style_edit_form(form);
}

// it causes some flicker when reloading or navigating grid
// it may be possible to have some custom formatter to do this as the grid is
// being created to prevent this
// or go back to default browser checkbox styles for the grid
function styleCheckbox(table) {

}

// unlike navButtons icons, action icons in rows seem to be hard-coded
// you can change them like this in here if you want
function updateActionIcons(table) {

}

// replace icons with FontAwesome icons like above
function updatePagerIcons(table) {
	var replacement = {
		'ui-icon-seek-first' : 'ace-icon fa fa-angle-double-left bigger-140',
		'ui-icon-seek-prev' : 'ace-icon fa fa-angle-left bigger-140',
		'ui-icon-seek-next' : 'ace-icon fa fa-angle-right bigger-140',
		'ui-icon-seek-end' : 'ace-icon fa fa-angle-double-right bigger-140'
	};
	$('.ui-pg-table:not(.navtable) > tbody > tr > .ui-pg-button > .ui-icon')
			.each(function() {
				var icon = $(this);
				var $class = $.trim(icon.attr('class').replace('ui-icon', ''));

				if ($class in replacement)
					icon.attr('class', 'ui-icon ' + replacement[$class]);
			})
}

function enableTooltips(table) {
	$('.navtable .ui-pg-button').tooltip({
		container : 'body'
	});
	$(table).find('.ui-pg-div').tooltip({
		container : 'body'
	});
}

//js日期格式化
Date.prototype.format = function(fmt) { 
    var o = { 
       "M+" : this.getMonth()+1,                 //月份 
       "d+" : this.getDate(),                    //日 
       "h+" : this.getHours(),                   //小时 
       "m+" : this.getMinutes(),                 //分 
       "s+" : this.getSeconds(),                 //秒 
       "q+" : Math.floor((this.getMonth()+3)/3), //季度 
       "S"  : this.getMilliseconds()             //毫秒 
   }; 
   if(/(y+)/.test(fmt)) {
           fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length)); 
   }
    for(var k in o) {
       if(new RegExp("("+ k +")").test(fmt)){
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));
        }
    }
   return fmt; 
}