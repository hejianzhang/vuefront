<template>

                        <el-form :model="interface" ref="interface" label-width="100px" class="demo-dynamic">
                            <el-form-item prop="id"  label="id"   >
                            <el-input v-model="interface.id"></el-input>
                            </el-form-item>
                            <el-form-item prop="name"  label="名字"  >
                            <el-input v-model="interface.name"></el-input>
                            </el-form-item>
                            <el-form-item prop="desc"  label="描述"  >
                            <el-input v-model="interface.desc"></el-input>
                            </el-form-item>
                            <el-form-item prop="input"  label="输入值" >
                            <el-input v-model="interface.input"></el-input>
                            </el-form-item>
                            
                            <el-form-item>
                            <el-button type="primary" @click="submitForm('interface')">提交</el-button>
                            <el-button @click="addDomain">新增域名</el-button>
                            <el-button @click="resetForm('interface')">重置</el-button>
                            </el-form-item>
                        </el-form>
                        
</template>

<script>
  export default {
    data() {
      return {
        interface: {
          id:'',
          name:'',
          desc:'',
          'input':{},
          'expectResult':{}

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
        console.log(this.$refs[formName])
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