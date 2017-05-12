/*
* @desc jqgrid导出excel控件
* @title 表格名称
* @date 日期
* @excelApp 当saveFile=false时，excel = new ActiveXObject("Excel.Application");
* @saveFile 是否保存， true=保存并关闭ExcelApplication, false=不保存并返回excel = new ActiveXObject("Excel.Application"),用于导出多张sheet
* @fileName 保存的文件名
*/
$.fn.jqgridToExcel = function (title, date, excelApp, saveFile, fileName) {
    var jqgrid = this;
    //var title = jqgrid.getGridParam('colNames');
    var param = jqgrid.getGridParam('postData')
    var excel;
    if (excelApp == null || excelApp == undefined) {

        try {
            excel = new ActiveXObject("Excel.Application");
        }
        catch (e) {
            alert("要导出Excel文件，您必须安装Excel电子表格软件，同时浏览器须使用“ActiveX 控件”，您的浏览器须允许执行控件。");
            return "";
        }
    }
    else {
        excel = excelApp;
    }
    //控制execl是否打开  true 打开  ,false  不打开
    excel.Visible = false;

    var workBook;
    if (excel.Workbooks.Count < 1) {
        workBook = excel.Workbooks.Add();
    }
    else {
        workBook = excel.Workbooks(1);
    }
    workBook.Worksheets.Add();

    var sheet = workBook.ActiveSheet; //workBook.ActiveSheet 等同  workBook.Worksheets(1)
    sheet.name = title;

    //调用公共方法
    var rowNum = 0;
    jqgridExcelListPublic(workBook, jqgrid, title, date, sheet, param, rowNum);
    /*内容设置结束*/

    excel.UserControl = false;

    //是否保存？
    if (saveFile == true) {
        if (fileName == '' || fileName == undefined) {
            //no code here!!!
        } else {
            sheet.SaveAs(fileName);
        }
        excel.Quit();
        return jqgrid;
    }
    else {
        return excel;
    }
}

/**
* @desc 导出多个sheet的excel
* 原本思路是在绑定数据的时候在生成所需要的sheet,因未能解决sheet排序问题就此作罢。
* 例如：有sheet1、sheet2、sheet3 ，当在生成一个sheet4排序是sheet4、sheet1、sheet2、sheet3 ，
* 查看资料发现VB代码可以控制sheet显示的问题，js貌似没发现。
* 所以现在换了种方式，先计算本次导数所需要的所有sheet,虽说添加出来的顺序也是sheet4、sheet1、sheet2、sheet3,
* 但当填充数据的时候是按照现在的顺序填充。
* @author wxy
* @param fileName 文件标题及文件名
* @param fdate 日期 
* @param urlArr url数组，设置数据来源
* @param showTypeArr 数据显示类型数组,设置当前数据是显示在上一个sheet中还是要重新新建个sheet
* @param paramArr 查询参数数组，数据过滤时时候
* 
*/
var idTmr = null;
$.fn.jqgridToExcelList = function (fileName, fdate, urlArr, showTypeArr, paramArr) {
    //判断系统类型  暂时注释
    //	var sysType = detectOS();

    var jqgrid = this;
    var param = jqgrid.getGridParam('postData');
    try {
        var excel = new ActiveXObject("Excel.Application");
    }
    catch (e) {
        alert("要导出Excel文件，您必须安装Excel电子表格软件，同时浏览器须使用“ActiveX 控件”，您的浏览器须允许执行控件。 ");
        return "";
    }
    //控制execl是否打开  true 打开  ,false  不打开
    excel.Visible = true;
    var workBook = excel.Workbooks.Add();
    var sheet = null;
    var rowNum = 0; //数据显示行
    var count = 0; //当前sheet 显示第几次url返回的数据，用于计算当前是第几个sheet在生成数据

    //获取到当前new出excel的sheet数量  ，经测试win7默认3个sheet，xp默认1个sheet
    var len = workBook.Sheets.count;
    //计算生成当前导出excel所需的sheet，如果当前new的excel中sheet不够用就需要生成
    for (var j = 0; j < urlArr.length; j++) {
        if (j >= len && showTypeArr[j]) {
            workBook.Sheets.add;
        }
    }

    //给excel绑定数据
    for (var i = 0; i < urlArr.length; i++) {
        var sheetNum = i + 1;
        if (i != 0) {
            param = paramArr[i];
        }

        //showTypeArr 值为true: 表示新的sheet ,fasle 表示使用上一个sheet并且要记录count
        if (showTypeArr[i]) {
            sheetNum = sheetNum - count;
            sheet = workBook.Worksheets(sheetNum);
            sheet.name = "第【" + sheetNum + "】层";
            rowNum = 0;
        } else {
            count++;
        }
        jqgrid = urlArr[i];
        rowNum = jqgridExcelListPublic(workBook, jqgrid, fileName, fdate, sheet, param, rowNum);
    }

    /*内容设置结束*/
    excel.UserControl = true;
    //	fileName = excel.Application.GetSaveAsFilename(fileName+".xls","Excel Spreadshsheets (*.xls),*.xls,(*.xlsx),*.xlsx");
    //	if(fileName!=false)sheet.SaveAs(fileName);

    var fd = new ActiveXObject("MSComDlg.CommonDialog");
    fd.Filter = "Excel Spreadshsheets (*.xls),*.xls,(*.xlsx),*.xlsx"; //過濾文件類型，現在就只能存成.xml的文件了
    fd.FilterIndex = 2;
    fd.MaxFileSize = 128;
    fd.ShowSave(); //這個是儲存的對話框，如果是需要打開的話，就要用fd.ShowOpen();
    sheet.SaveAs(fd.FileName);

    excel.Quit();
    workBook = null;
    excel = null;
    activeSheet = null;
    idTmr = window.setInterval("Cleanup();", 1);
    return jqgrid;
}

function Cleanup() {
    window.clearInterval(idTmr);
    CollectGarbage();
}


/**
* @desc 一个sheet中显示多个列表 的公共方法
* @author wxy
* @param fileName 文件标题及文件名
* @param fdate 日期 
*/
var jqgridExcelListPublic = function (workBook, jqgrid, fileName, fdate, sheet, param, rowNum) {

    var rowNums = 0;
    var url = jqgrid.getGridParam('url');
    param.page = 1;
    param.rows = 1000000000; //设置所有数据一次返回
    $.ajax({
        type: "POST",
        url: url,
        data: param,
        async: false,
        success: function (back) {
            var data = back;
            if (typeof back == "string") data = $.parseJSON(back);
            var re = /&nbsp;/g;  //正则、匹配所有空格
            var viewValue = null;
            try {
                var colModel = jqgrid.getGridParam('colModel');
                var title = jqgrid.getGridParam('colNames');
                /*列头设置开始*/
                var start = 3;
                if (rowNum != 0) {
                    start = rowNum + 3;
                }
                var col = 1;
                var tiCon = title.length;
                for (var i = 0; i < tiCon; i++) {
                    //列出不隐藏的列头项
                    if (title[i].length != 0 && title[i].indexOf("<input") < 0 && colModel[i].hidden == false) {
                        sheet.Cells(start, col).HorizontalAlignment = 3; //居中显示
                        sheet.Cells(start, col).Font.Bold = true; //设置粗体
                        sheet.Cells(start, col).value = title[i];
                        sheet.Cells(start, col).Borders.LineStyle = 1; //边框样式
                        sheet.Cells(start, col).Borders.ColorIndex = 10; //单元格边框颜色
                        sheet.Cells(start, col).Interior.ColorIndex = 2; //单元格底色
                        col++;
                    }
                }
                /*列头设置结束*/

                if (rowNum == 0) {
                    /*标题开始*/
                    sheet.Range("A1", sheet.Cells(1, col - 1)).MergeCells = true; //合并标题单元格
                    sheet.Cells(1, 1).HorizontalAlignment = 3; //居中显示
                    sheet.Cells(1, 1).Font.Bold = true; //设置粗体
                    sheet.Cells(1, 1).Font.Size = 15; //字体大小
                    sheet.Cells(1, 1).Font.ColorIndex = 10; //字体颜色
                    sheet.Cells(1, 1).value = fileName;
                    /*标题结束*/

                    sheet.Range("A2", sheet.Cells(2, col - 1)).MergeCells = true; //合并时间单元格
                    sheet.Cells(2, 1).HorizontalAlignment = 2; //居左显示
                    sheet.Cells(2, 1).value = fdate;
                }

                /*内容设置开始*/
                var row = data.rows;
                var count = row.length;
                rowNums = start + count;
                var colModellen = colModel.length;
                for (var i = 0; i < count; i++) {
                    var cocl = 1;
                    for (var j = 0; j < colModellen; j++) {
                        //列出毎列内容
                        if (colModel[j].hidden == false/*&&colModel[j].index!=undefined*/) {
                            sheet.Cells(start + 1 + i, cocl).HorizontalAlignment = 3; //居中显示
                            sheet.Cells(start + 1 + i, cocl).Borders.LineStyle = 1; //边框样式
                            sheet.Cells(start + 1 + i, cocl).Borders.ColorIndex = 10; //单元格边框颜色
                            sheet.Cells(start + 1 + i, cocl).NumberFormat = "@"; //将单元置为文本，避免非数字列被自动变成科学计数法和丢失前缀的0
                            viewValue = $(row[i]).attr(colModel[j].name);
                            if (colModel[j].formatter != undefined) {//如果定义了格式化方法
                                //								若有格式化，则需要格式化后显示
                                viewValue = colModel[j].formatter(viewValue);
                                //wangxiaoyuan 控制有连接的列
                                if (viewValue.indexOf("href", 1) != -1) {
                                    var s = viewValue.indexOf(">", 1);
                                    var e = viewValue.indexOf("<", 2);
                                    var strValue = viewValue.substring(s + 1, e);
                                    viewValue = strValue;
                                }
                            }
                            if (viewValue != null) viewValue = (viewValue.toString()).replace(re, "");
                            if (viewValue == undefined) {
                                viewValue = '';
                            }
                            //viewValue 前面加空格是为了处理 2/2的数据格式，cells默认会理解为日期
                            sheet.Cells(start + 1 + i, cocl).value = " " + viewValue;
                            cocl++;
                        }
                    }
                }
                //列自增长
                sheet.Columns.AutoFit();

            } catch (e) {
            }

        }
    });
    return rowNums;
}


/**
* @desc jqgrid导入excel控件
* @fileName 要导入的excel文件名
* @sheet  数据源所在的sheet序号[1,2....N]
* @columnNameRowId 数据列名称所在的行号[1,2....N]，Excel列的名称与jqGrid列的name 或label相同则为匹配
* @paramData 固定参数，用于每一行，格式为：{ "name1": value1, "name2": value2 }
* @returnExcelApp 是否返回ExcelApp 对象：true 表示返回,其它不返回。
*/
$.fn.jqgridFromExcel = function (fileName, sheetNum, columnNameRowId, paramData, excelApp, returnExcelApp) {

    var jqgrid = this;

    if (sheetNum == undefined || sheetNum < 1) {
        alert("请指定数据源所在的工作表序号sheetNum 。");
        return jqgrid;
    }

    if (columnNameRowId == undefined || columnNameRowId < 2) {
        alert("请指定列名所在行号columnNameRowId");
        return jqgrid;
    }

    var excel;
    if (excelApp == undefined || excelApp == null) {
        if (fileName == undefined || fileName == '') {
            alert("请选择Excel格式数据源文件fileName 。");
            return jqgrid;
        }
        //创建操作EXCEL应用程序的实例  
        excel = new ActiveXObject("Excel.application");

    } else {
        excel = excelApp;
    }


    //列名所在的行号
    var rowid = columnNameRowId;

    //打开指定路径的excel文件  
    var oWB = excel.Workbooks.open(fileName);

    //操作第一个sheet(从一开始，而非零)  
    oWB.worksheets(sheetNum).select();
    var oSheet = oWB.ActiveSheet;

    //使用的行数  
    var rows = oSheet.usedrange.rows.count;

    //jqGrid列
    var colModel = jqgrid.getGridParam('colModel');

    //Excel列(第rowid行）
    var colXls = new Array();

    var strCol = "{";

    var bAdded = false;
    //构造jqGrid列与Excel列的对应关系，Excel列的名称与jqGrid列的name 或label相同则为匹配。
    for (var j = 0; j < colModel.length; j++) {
        bAdded = false;
        for (var i = 1; i <= oSheet.usedrange.columns.count; i++) {
            var colName = oSheet.Cells(rowid, i).value;
            if (colName == colModel[j].name || colName == colModel[j].label) {
                colXls.push(i);
                bAdded = true;
                break;
            }
        }
        if (bAdded == false) {
            colXls.push(0);
        }
    }

    //读一行，添加一行
    try {
        for (var i = rowid + 1; i <= rows; i++) {
            var jsonRow = new Array();

            //读取excel数据来填充行
            for (var j = 0; j < colXls.length; j++) {
                jsonRow.push("" + colModel[j].name + ":'" + (colXls[j] > 0 ? oSheet.Cells(i, colXls[j]).value : "") + "'");
            }

            //为每一行添加固定数据
            for (var key in paramData) {
                jsonRow.push("" + key + ":'" + paramData[key] + "'");
            }

            //转化为json对象
            eval("jsonRow={" + jsonRow.join(",") + "};");

            //为jqGrid添加行
            /*
            $("#jqgrid").addRowData(rowId, data, pos, idx);   
            pos可以为[first,last,before,after],为后两者是需要指定相对的行ID   
            $("#jqgrid").addRowData("1", { "name": "test", "age": 12 }, "first");  
            */
            jqgrid.addRowData(i, jsonRow, "last");
        }
    } catch (e) {
        alert(e);
    }
    if (returnExcelApp == true) {
        return excel;
    } else {

        //退出操作excel的实例对象  
        oXL.Application.Quit();
        //手动调用垃圾收集器  
        CollectGarbage();
        return jqgrid;
    }
}