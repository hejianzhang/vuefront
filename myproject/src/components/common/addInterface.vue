<template>

                        <el-form :model="interface" ref="interface" label-width="100px" class="demo-dynamic">
                            
                            <el-form-item prop="name"  label="名字"  >
                            <el-input v-model="interface.name"></el-input>
                            </el-form-item>
                            <el-form-item prop="desc"  label="描述"  >
                            <el-input v-model="interface.desc"></el-input>
                            </el-form-item>
                            <el-form-item prop="input"  label="输入值" >
                            <el-input v-model="interface.input"></el-input>
                            </el-form-item>
                            <el-form-item prop="expectResult"  label="输出结果" >
                            <el-input v-model="interface.expectResult"></el-input>
                            </el-form-item>
                            
                            <el-form-item>
                            <el-button type="primary" @click="submitForm()">提交</el-button>
                            <el-button @click="addDomain">新增域名</el-button>
                            <el-button @click="resetForm('interface')">重置</el-button>
                            </el-form-item>
                        </el-form>
                        
</template>

<script>
   import axios from 'axios'
  export default {
    props:['testdata'],
    data() {
      return {
        interface: {
          id:'',
          name:'',
          desc:'',
          'input':'',
          'expectResult':''

        },
        interface1: {
          id:'',
          casename:'',
          casedesc:'',
          caseinput:'',
          caseexpectResult:''

        },
       
        dynamicValidateForm: {
          domains: [{
            value: ''
          }],
          email: ''
        }
      };
    },
    methods: {
      submitForm(formName) {
      //  this.interface.input=JSON.parse(this.interface.input)
      //  this.interface.expectResult=JSON.parse(this.interface.expectResult)
       this.testdata.push(this.interface)
       this.interface1.id=this.interface.id
       this.interface1.casename=this.interface.name
       this.interface1.casedesc=this.interface.desc
       this.interface1.caseinput=this.interface.input
       this.interface1.caseexpectResult=this.interface.expectResult
       var that=this.$parent
       axios.post('http://localhost:8081/myapp/mvc/add.do', this.interface1, {
                      headers: {
                           'X-Requested-With': 'XMLHttpRequest',
                           
                      }
                  })
                  .then(function (response) {
                    console.log(response);
                    that.updatedate()
                  })
                  .catch(function (error) {
                    console.log(error);
                  });
       this.$nextTick(function () {
              
            })
      alert("id:  "+this.interface.id+"  name: "+this.interface.name+"   添加成功")
      },
      resetForm(formName) {
        this.$refs[formName].resetFields();
      },
      removeDomain(item) {
        var index = this.dynamicValidateForm.domains.indexOf(item)
        if (index !== -1) {
          this.dynamicValidateForm.domains.splice(index, 1)
        }
      },
      addDomain() {
        this.dynamicValidateForm.domains.push({
          value: '',
          key: Date.now()
        });
      }
    }
  }
</script>
<style>
.newinterface{
    position: fixed;
    z-index: 100px;
    bottom: 0;
    right: 0;
    width: 50%;
    height: 100%;
    overflow: auto;
    background: rgba(7, 17, 27, 0.8);
    border-bottom: 1px solid #D3dce6;
    background-color: #F9FAFC;
}
</style>