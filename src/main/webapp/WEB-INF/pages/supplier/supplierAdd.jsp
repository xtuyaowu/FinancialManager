<%--
  Created by IntelliJ IDEA.
  User: MoonFollow
  Date: 2017/10/11
  Time: 14:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <title>供应商添加</title>
    <!-- 引入 BootStrap 全家桶 -->
    <script src="../res/js/jquery-3.2.1.min.js"></script>
    <script src="../res/js/bootstrap.min.js"></script>
    <script src="../res/js/bootstrap-datepicker.js"></script>
    <script src="../res/js/bootstrap-datepicker.zh-CN.js"></script>
    <link rel="stylesheet" href="../res/css/bootstrap.min.css"/>

    <!-- 引入Vue.js -->
    <script src="../res/js/vue.min.js"></script>
    <style>
        html,body{
            height: 100%;
            padding: 0px;
        }
        .supplier-head{
            height: 50px;
            line-height: 50px;
        }
        .title{
            height: 38px;
            font-size: 21px;
        }
        .hr{
            border-bottom: 1px solid #9d9d9d;
            margin-top: 0;
        }
        .btn-submit{
            width: 200px;
        }
        .datepicker:hover,
        #dep,
        #city,
        #calender{
            cursor: pointer;
        }
        .row .control-label{
            padding: 7px 0;
            text-align: right;
        }
        .borderx{
            height: 38px;
            line-height: 38px;
            border-bottom: 1px solid #9d9d9d;
            margin: 10px 0px 35px 0px;
            position: relative;
        }
        .borderx span{
            display: inline-block;
            height: 38px;
            font-size: 21px;
        }
        .pibu{
            position: absolute;
            right: 10px;
            top: 0;
        }
        .file-up-in:hover{
            cursor: pointer;
        }
    </style>
</head>
<body>
<div class="app container-fluid width-100per top-content">
    <div class="supplier-head">供应商管理 > 新增供应商信息</div>
    <div class="borderx">
        <span class="title">供应商基本信息添加</span>
        <security:authorize access="hasAnyRole('ROLE_ADMIN')">
        <button class="btn btn-success pibu col-sm-1" data-toggle="modal" data-target="#pibudialog">批量导入</button>
        </security:authorize>
    </div>
    <div class="row">
        <!-- <div class="content-line">
            <div class="item-left content-item">
                <div class="item-left item-name"> -->
        <label class="control-label col-md-1 col-sm-2 col-xs-2" for="supplierName">名称：</label>
        <!-- </div> -->
        <div class="form-group col-md-3 col-sm-4 col-xs-4">
            <input type="text" class="form-control " propName="提供商名称" id="supplierName" data-toggle="tooltip" data-placement="top"  v-model="supplierName" placeholder="请输入供应商名称...">
        </div>
        <!-- </div>
        <div class="item-right content-item">
            <div class="item-left item-name"> -->
        <label class="control-label col-md-1 col-sm-2 col-xs-2" for="adtitude" class="">资质：</label>
        <!-- </div> -->
        <div class="form-group col-md-3 col-sm-4 col-xs-4">
            <input type="text" class="form-control" id="adtitude" propName="提供商资质" data-toggle="tooltip" data-placement="top" :title="errorType.supplierAdtitudeError" v-model="adtitude" placeholder="请输入供应商资质...">
        </div>
        <!-- </div>
    </div>
    <div class="content-line customTitle">
        <div class="item-left content-item">
            <div class="item-left item-name"> -->
        <label class="control-label col-md-1 col-sm-2 col-xs-2" for="address">地址：</label>
        <!-- </div> -->
        <div class="form-group col-md-3 col-sm-4 col-xs-4" >
            <input type="text" class="form-control" v-model="address" id="address" propName="提供商地址" data-toggle="tooltip" data-placement="top" :title="errorType.supplierAddressError" placeholder="请输入供应商地址...">
        </div>
        <!-- </div>
        <div class="item-right content-item">
            <div class="item-left item-name"> -->
        <label class="control-label col-md-1 col-sm-2 col-xs-2" for="contactPerson">联系人：</label>
        <!-- </div> -->
        <div class="form-group col-md-3 col-sm-4 col-xs-4">
            <input type="text" v-model="contact" class="form-control" id="contactPerson" propName="提供商联系人" data-toggle="tooltip" data-placement="top" :title="errorType.supplierContactNameError" placeholder="请输入供应商联系人...">
        </div>
        <!--  </div>
     </div>
     <div class="content-line customTitle">
         <div class="item-left content-item">
             <div class="item-left item-name"> -->
        <label class="control-label col-md-1 col-sm-2 col-xs-2" for="tel">联系电话：</label>
        <!-- </div> -->
        <div class="form-group col-md-3 col-sm-4 col-xs-4" >
            <input type="number" checked class="form-control" v-model="tel" id="tel" propName="提供商联系电话" data-toggle="tooltip" data-placement="top" :title="errorType.supplierTelError" placeholder="请输入供应商联系电话...">
        </div>
        <!-- </div>
        <div class="item-right content-item">
            <div class="item-left item-name"> -->
        <label class="control-label col-md-1 col-sm-2 col-xs-2" for="business">主营业务：</label>
        <!-- </div> -->
        <div class="form-group col-md-3 col-sm-4 col-xs-4">
            <input type="text" class="form-control" v-model="business" id="business" propName="提供商主营业务" data-toggle="tooltip" data-placement="top" :title="errorType.supplierBusinessError" placeholder="请输入供应商主营业务...">
        </div>
        <!--  </div>
     </div>
     <div class="content-line">
         <div class="item-left content-item">
             <div class="item-left item-name"> -->
        <label class="control-label col-md-1 col-sm-2 col-xs-2" for="tel">签约时间:</label>
        <!-- </div> -->
        <div class="form-group col-md-3 col-sm-4 col-xs-4" >
            <input class="form-control" propName="提供商签约时间" id="calender" name="contractTime" placeholder="签约时间" type="text">
        </div>
        <!-- </div> -->
    </div>
    <div class="title">供应商自定义信息添加</div>
    <hr class="hr">
    <input type="hidden" name="customKey">
    <input type="hidden" name="customValue">
    <div class="form-group form-inline row" v-for="(item,index) in customFields">
        <div class="col-md-2 col-sm-2 col-xs-2"></div>
        <div class="col-md-4 col-sm-4 col-xs-4">
            <input type="text" class="form-control" style="width: 100%;" v-model="customFields[index].key" placeholder="自定义属性">
        </div>
        <div class="col-md-4 col-sm-4 col-xs-4">
            <input type="text" class="form-control" style="width: 100%;" v-model="customFields[index].value" placeholder="属性值">
        </div>
        <div class="col-md-2 col-sm-2 col-xs-2">
            <span class="btn btn-sm btn-danger glyphicon glyphicon-minus" @click="delField(index)"></span>
            <span class="btn btn-sm btn-primary glyphicon glyphicon-plus" v-if="index==(customFields.length-1)" @click="addField(index,customFields[index])"></span>
        </div>
    </div>
    <div class="col-sm-12 col-xs-12" style="text-align: center;margin-top: 50px;">
        <input type="button" data-loading-text="提交中..." id="submitBtn" class="btn btn-primary btn-submit" @click="submitData()" value="提交">
        <a href="downloadSuccessFile" class="btn btn-success" v-if="hasSuccessFile">下载插入成功供应商列表</a>
    </div>
    <button id="modalButton" type="button" hidden data-toggle="modal" data-target="#myModal"></button>

    <div class="modal fade" id="pibudialog" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">批量导入</h4>
                </div>
                <div class="modal-body">
                    <form name="fileUpload">
                        <input type="file" id="fileSource" hidden style="display: none">
                    </form>
                    <div class="input-group">
                        <input type="text" class="form-control file-up-in" id="fileSource-show" readonly placeholder="请选择文件..." @click="choseFile()">
                        <span class="input-group-btn">
                                <button class="btn btn-primary" type="button" @click="uploadFileAction()">上传并导入</button>
                        </span>
                    </div>
                </div>
                <div class="modal-footer" >
                    <a href="downloadErrorFile" class="btn btn-warning" v-if="hasErrorFile">下载未导入供应商信息</a>
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

    <!-- Modal -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">提示</h4>
                </div>
                <div class="modal-body">
                    {{modalStatus}}
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    var data = {
        customFields:[{}],
        supplierName:"",
        adtitude:"",
        address:"",
        contact:"",
        tel:"",
        business:"",
        contractTime:"",
        errorType:{
            supplierNameError:"",supplierAdtitudeError:"",supplierAddressError:"",
            supplierContactNameError:"",supplierTelError:"",supplierBusinessError:""
        },
        isError:[],
        modalStatus:"",
        hasErrorFile:false,
        hasSuccessFile:false
    };
    var vm = new Vue({
        el:'.app',
        data:data,
        methods:{
            addField(index,item){
                console.log(this.customFields[index].key);
                console.log(item.value);
                this.customFields.push({});
            },
            delField(index){
                if(this.customFields.length==1){
                    return;
                }
                this.customFields.splice(index,1);
            },
            submitData(){
                if(tableCheck()){
                    return;
                }
                var $btn = $('#submitBtn').button('loading');
                var _customFields ="";
                var index;
                for(index in this.customFields){
                    if(this.customFields[index].key==""||this.customFields[index].key==undefined){
                        continue;
                    }
                    _customFields+=(this.customFields[index].key+"="+(this.customFields[index].value==undefined? "":this.customFields[index].value)+";");
                }
                _customFields=_customFields;
                $.post("add",
                    {
                        "business":this.business,
                        "tel":this.tel,
                        "contactName":this.contact,
                        "address":this.address,
                        "adtitude":this.adtitude,
                        "name":this.supplierName,
                        "contractTime":this.contractTime,
                        "customMessage":_customFields
                    },
                    function(data,status){
                        refreshDownloadExcelState();
                        if(status){
                            console.log(data);
                            var _data = eval(data);
                            if(_data.success===undefined){
                                var _data = eval({data});
                                vm.modalStatus="数据添加失败！";
                                $('#modalButton').click();
                            }else{
                                vm.modalStatus="数据添加成功！";
                                $('#modalButton').click();
                            }
                        }
                    });
                $btn.button('reset');
            }
        }
    });
    function tableCheck(){
        vm.contractTime=$('#calender')[0].value;
        var inputObj = $('.form-control');
        var i;
        var len = 7;
        var flag = false;
        for(i=0 ;i < len; i++){
            if(i == 1 ){
                continue;
            }
            if(inputObj[i].value==""){
                vm.isError[i]=true;
                flag = true;
                var propName = inputObj[i].getAttribute('propName');
                var id = inputObj[i].getAttribute('id');
                $(inputObj[i]).parent().addClass('has-error');
                var errorMessage = propName+"不能有特殊字符也不能为空！";
                $('#'+id).tooltip({
                    title:errorMessage
                });
            }else{
                var id = inputObj[i].getAttribute('id');
                $(inputObj[i]).parent().removeClass('has-error');
                $('#'+id).tooltip('destroy');
            }
        }
        if(vm.tel.length!=11){
            $('#tel').parent().addClass('has-error');
            $('#tel').tooltip({
                title:"电话号码长度为11位！"
            });
            return true;
        }
        return flag;
    }
    $('#calender').datepicker({
        language: 'zh-CN',
        autoclose: true,
        todayHighlight: true
    });
</script>

<script>
    $("input[type=file]").change(function(e){
        var path = e.target.value;
        var lastIndex = path.lastIndexOf('\\')+1;
        var value = path.substring(lastIndex);
        $('#fileSource-show')[0].value = value;
    });
    function choseFile() {
        $("#fileSource").click();
    }

    function uploadFileAction() {
        if($('#fileSource-show')[0].value==""){
            vm.modalStatus = '请选择文件！';
            $('#modalButton').click();
            return;
        }
        // 创建
        var form_data = new FormData();
        // 获取文件
        var file_data = $("#fileSource").prop("files")[0];
        // 把所以表单信息
        form_data.append("eqXsl", file_data);
        $.ajax({
            type: "POST",
            url: "upload?time="+new Date().getTime(),
            processData: false,  // 注意：让jQuery不要处理数据
            contentType: false,  // 注意：让jQuery不要设置contentType
            data: form_data,
            success: function(data){//成功方法
                var _data = eval(data);
                if(!_data){
                    vm.modalStatus = '发生未知错误，请联系管理员！';
                    $('#modalButton').click();
                }else if(_data.supplierErrorType){
                    vm.modalStatus = _data.supplierErrorType;
                    $('#modalButton').click();
                }else if(_data.hasInsertError){
                    vm.modalStatus = _data.hasInsertError;
                    $('#modalButton').click();
                    vm.showDownloadError = true;
                }else if(_data.errorType){
                    vm.modalStatus = _data.errorType;
                    $('#modalButton').click();
                }else if(_data.success){
                    vm.modalStatus = _data.success;
                    $('#modalButton').click();
                    vm.showDownloadError = false;
                }else{
                    vm.modalStatus = '发生未知错误，请联系管理员！';
                    $('#modalButton').click();
                }
                refreshDownloadExcelState();
            },error:function(){//请求失败方法
                alert("系统繁忙,请稍后再试！");
            }
        });
        refreshDownloadExcelState();
    }
    refreshDownloadExcelState();
    function refreshDownloadExcelState() {
        $.get("hasErrorFile",function (data, status) {
            if(status == "success"){
                var _data = eval(data);
                console.log(_data);
                if(!_data){
                    vm.modalStatus = '发生未知错误，请联系管理员！';
                    $('#modalButton').click();
                }else if(_data.state){
                    if(_data.state=="true"){
                        vm.hasErrorFile = true;
                    }else {
                        vm.hasErrorFile = false;
                    }
                }else if(_data.supplierErrorType){
                    vm.modalStatus = _data.supplierErrorType;
                    $('#modalButton').click();
                }else if(_data.errorType){
                    vm.modalStatus = _data.errorType;
                    $('#modalButton').click();
                }
            }
        });
        $.get("hasSuccessFile",function (data, status) {
            if(status == "success"){
                var _data = eval(data);
                console.log(_data);
                if(!_data){
                    vm.modalStatus = '发生未知错误，请联系管理员！';
                    $('#modalButton').click();
                }else if(_data.state){
                    if(_data.state=="true"){
                        vm.hasSuccessFile = true;
                    }else{
                        vm.hasSuccessFile = false;
                    }
                }else if(_data.supplierErrorType){
                    vm.modalStatus = _data.supplierErrorType;
                    $('#modalButton').click();
                }else if(_data.errorType){
                    vm.modalStatus = _data.errorType;
                    $('#modalButton').click();
                }
            }
        });
    }
</script>
</html>