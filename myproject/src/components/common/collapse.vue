<template>
<div class="testRunResults">
<h1 class="title1">测试结果</h1>
<el-input class="input" v-model="input" size="small" width="30px" placeholder="请输入筛选接口"> </el-input>
<el-button class="searchbutton" size="small" type="success" @click="searchResults(input)">搜索</el-button>
<el-button class="searchbutton" size="small" type="primary" @click="refresh">刷新</el-button>
<el-collapse v-for="(key,value) in testResults" :key="value" accordion>
<el-collapse-item :title="key[Object.keys(key)[0]]"  name="1">
 <el-collapse v-for="(key1,value1) in key[Object.keys(key)[1]]" :key="value1" accordion>
  <el-collapse-item :title="key1[Object.keys(key1)[0]]" name="1">
    <div  v-for="(key2,value2) in key1[Object.keys(key1)[1]]" :key="value2">

        <el-tag  color="green" v-if="key2=== 'sucess'" type="success">{{value2}}:</el-tag>
        <el-tag  color="red"v-else-if="key2=== 'failed'" type="danger">{{value2}}:</el-tag>
        <el-tag  v-else type="primary">{{value2}}:</el-tag>
        {{key2}}
        </div>
  </el-collapse-item>
</el-collapse> 
</el-collapse-item>
</el-collapse>
  </div>
</template>
<script>
export default {
   data() {
      return {
        input: '',
        oldata:[],
        testResults: {
            1:{
            "name":"TestSuite场景1",
            "data":{
                testcase1:{
                    name:"测试用例1",
                "testdata" :{ 
                    result:"sucess",
                    message: 0
                }
                },
                testcase2:{
                    name:"测试用例2",
                "testdata":{  
                    result: "failed",
                    message: "whyyyyyyyyy"
                }
                },
                testcase3:{
                    name:"测试用例3",
                "testdata":{    
                    result: "no running",
                    message: "null"
                }
                },
                testcase4:{
                    name:"测试用例1",
                "testdata":{  
                    result: "no running",
                    message: "null"
                }
                }
            }
            },
           2:{
            "name":"TestSuite场景2",
            "data":{
                testcase1:{
                    name:"测试用例1",
                "testdata" :{ 
                    result:"sucess",
                    message: 0
                }
                },
                testcase2:{
                    name:"测试用例2",
                "testdata":{  
                    result: "failed",
                    message: "whyyyyyyyyy"
                }
                },
                testcase3:{
                    name:"测试用例3",
                "testdata":{    
                    result: "no running",
                    message: "null"
                }
                },
                testcase4:{
                    name:"测试用例1",
                "testdata":{  
                    result: "no running",
                    message: "null"
                }
                }
            }
            }
        }
      };
    },
    methods:{
        searchResults(input){
            // console.log("aaaaaaaaaaaaaa")
            let test = []
            for( var key2 in this.testResults){
                let name=this.testResults[key2]
                if(name[Object.keys(name)[0]].indexOf(input) !== -1){
                    test.push(this.testResults[key2])
                 }
                
            }
           
     
           


            console.log(test.length)
            this.oldata=JSON.parse(JSON.stringify(this.testResults))
            this.testResults = test
            this.$nextTick(function () {
             
            })
        },
        refresh(){
              this.testResults =this.oldata
        }

    }
}
</script>
<style>
.title1{
    align-content: center
}
</style>
