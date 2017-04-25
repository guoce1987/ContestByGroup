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
		$("ul.nav.nav-list li.active a").click();
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

// js导出表的两种方法
function ExportToExcel(dataSource, ReportTitle, label) {
	var arrData;
	arrData = typeof dataSource != 'object' ? JSON.parse(dataSource)
			: dataSource;
	var Excel = '';
	// Set Report title in first row or line
	Excel += ReportTitle + '\r\n\n';

	// This condition will generate the Label/Header
	if (label) {
		var row = "";

		// This loop will extract the label from 1st index of on array
		for ( var index in arrData[0]) {

			// Now convert each value to string and comma-seprated
			row += index + ',';
		}

		row = row.slice(0, -1);

		// append Label row with line break
		Excel += row + '\r\n';
	}

	// 1st loop is to extract each row
	for (var i = 0; i < arrData.length; i++) {
		var row = "";

		// 2nd loop will extract each column and convert it in string
		// comma-seprated
		for ( var index in arrData[i]) {
			row += '"' + arrData[i][index] + '",';
		}

		row.slice(0, row.length - 1);

		Excel += row + '\r\n';
	}

	if (Excel == '') {
		return;
	}

	// Generate a file name
	var fileName = "MyCSVReport_";
	// this will remove the blank-spaces from the title and replace it with an
	// underscore
	fileName += ReportTitle.replace(/ /g, "_");

	// Initialize file format you want csv or xls
	var uri = 'data:text/csv;charset=utf-8,' + escape(Excel);
	var link = document.createElement("a");
	link.href = uri;

	link.style = "visibility:hidden";
	link.download = fileName + ".csv";

	// this part will append the anchor tag and remove it after automatic click
	document.body.appendChild(link);
	link.click();
	document.body.removeChild(link);
}

function JSONToCSVConvertor(JSONData, ReportTitle, ShowLabel) {
	// If JSONData is not an object then JSON.parse will parse the JSON string
	// in an Object
	var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;

	var CSV = '';
	// Set Report title in first row or line

	CSV += ReportTitle + '\r\n\n';

	// This condition will generate the Label/Header
	if (ShowLabel) {
		var row = "";

		// This loop will extract the label from 1st index of on array
		for ( var index in arrData[0]) {

			// Now convert each value to string and comma-seprated
			row += index + ',';
		}

		row = row.slice(0, -1);

		// append Label row with line break
		CSV += row + '\r\n';
	}

	// 1st loop is to extract each row
	for (var i = 0; i < arrData.length; i++) {
		var row = "";

		// 2nd loop will extract each column and convert it in string
		// comma-seprated
		for ( var index in arrData[i]) {
			row += '"' + arrData[i][index] + '",';
		}

		row.slice(0, row.length - 1);

		// add a line break after each row
		CSV += row + '\r\n';
	}

	if (CSV == '') {
		alert("Invalid data");
		return;
	}

	// Generate a file name
	var fileName = "MyReport_";
	// this will remove the blank-spaces from the title and replace it with an
	// underscore
	fileName += ReportTitle.replace(/ /g, "_");

	// Initialize file format you want csv or xls
	var uri = 'data:text/csv;charset=utf-8,' + escape(CSV);

	// Now the little tricky part.
	// you can use either>> window.open(uri);
	// but this will not work in some browsers
	// or you will not get the correct file extension

	// this trick will generate a temp <a /> tag
	var link = document.createElement("a");
	link.href = uri;

	// set the visibility hidden so it will not effect on your web-layout
	link.style = "visibility:hidden";
	link.download = fileName + ".csv";

	// this part will append the anchor tag and remove it after automatic click
	console.log(document.body);
	document.body.appendChild(link);
	link.click();
	document.body.removeChild(link);
}

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