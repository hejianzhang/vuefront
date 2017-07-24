<template>
<div class="testRunResults">
<h1 class="title1">测试结果</h1>
<el-input class="input" v-model="input" size="small" width="30px" placeholder="请输入筛选接口"> </el-input>
<el-button class="searchbutton" size="small" type="success" @click="searchResults(input)">搜索</el-button>
<el-button class="searchbutton" size="small" type="primary" @click="refresh">刷新</el-button>
<div  v-for="(item,index) in ss">
<el-collapse v-for="(key111,value) in item" :key="value" accordion>
<el-collapse-item :title="value"  name="1">  
 <el-collapse v-for="(key,value) in key111" :key="value" accordion>
<el-collapse-item :title="key[Object.keys(key)[0]].name"  name="1">
    <div v-for="(item,index) in key[Object.keys(key)[0]].data">
   
    <el-collapse   accordion>
  <el-collapse-item :title="item['name']" name="1">
    <div  v-for="(key2,value2) in item['testdata']" :key="value2">

        <el-tag  color="green" v-if="key2=== 'sucess'" type="success">{{value2}}:</el-tag>
        <el-tag  color="red"v-else-if="key2=== 'failed'" type="danger">{{value2}}:</el-tag>
        <el-tag  v-else type="primary">{{value2}}:</el-tag>
        {{key2}}
     </div>
  </el-collapse-item>
    </el-collapse>
  </div>

</el-collapse-item>
</el-collapse>  

</el-collapse-item>
</el-collapse>
</div>
</div>

</template>
<script>
import axios from 'axios'
export default {
    
   data() {
      return {
        input: '',
        oldata:[],
        ss:[],
      };
    },
    methods:{
        searchResults(input){
            var that=this
            let test = []
            for( var key2 in this.ss){
                let name=this.ss[key2]
                 for( var key3 in name){
              if(key3.indexOf(input) !== -1){
                    test.push(this.ss[key2])
                 }
                 } 
            }
            this.ss = test
            this.$nextTick(function () {
             
            })
        },
        refresh(){
           var that=this
            axios.get('http://localhost:8081/myapp/exResults/getAll.do', { headers: { 'X-Requested-With': 'XMLHttpRequest' } }).then(response => {
              that.ss = response.data
               console.log(that.ss)
            
           }),
           console.log(this.ss)
                this.$nextTick(function () {

            }) 
        }

    }
}
</script>
<style>
.title1{
    align-content: center
}
</style>
