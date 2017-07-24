<template>
    <div class="pos">
        <el-row>
            <el-col id="order-list" :span="12" class="pos-order">
                <el-tabs @tab-click="handleClick">
    
                    <el-tab-pane label="测试用例集合">
                        <el-card height="200px" class="box-card">
                           <div slot="header" class="clearfix">
                                <span style="line-height: 18px;">登陆信息</span>
                                <el-button style="float: right;" type="warning" @click="fresh">刷新</el-button>
                           </div>
                           <div class='text item'>brokerId:
                                <span class="userlogininfo">{{mydata1.brokerID}}</span>
                            </div>
                             <div class='text item'>密码:
                                <span class="userlogininfo">{{mydata1.password}}</span>
                            </div>
                             <div class='text item'>spi:
                                <span class="userlogininfo">{{mydata1.spi}}</span>
                            </div>
                             <div class='text item'>系统:
                                <span class="userlogininfo">{{mydata1.system}}</span>
                            </div>
                            <div class='text item'>用户:
                                <span class="userlogininfo">{{mydata1.userID}}</span>
                            </div>
                            </el-card>
                        
                        <div class="filter">
                            <el-input class="input" v-model="input" size="small" width="30px" placeholder="请输入筛选接口">
                            </el-input>
                            <el-button class="searchbutton" size="small" type="success" @click="search(input)">搜索
                            </el-button>
                            <el-button class="searchbutton" size="small" type="danger" @click="updatedate()">更新
                            </el-button>
                            <el-button class="searchbutton" size="small" type="warning" @click="addInterfaceFlag()">定义新接口
                            </el-button>
                             <el-button class="searchbutton" size="small" type="primary" @click="addselecttestcase()">批量添加选择用例
                            </el-button>
                        </div>
                        
    
                        <el-table :data="mydata1.testdata" border  @selection-change="handleSelectionChange1">
                            <el-table-column type="selection" width="50px"></el-table-column>
                            <el-table-column type="index" width="80px"></el-table-column>
                            <el-table-column prop="id" label="序号" size="small" width="80px"></el-table-column>
                            <el-table-column prop="name" label="接口名称" width="240px"></el-table-column>
                            <!-- <el-table-column prop="desc" size="small" label="描述" min-width="30%"></el-table-column> -->
                            <el-table-column label="操作" width="320px">
                                <template scope="scope">
                                    <el-button type="danger" size="small" @click="deltestdata(scope.$index, scope.row)">删除</el-button>
                                    <el-button type="primary" size="small" @click="addList(scope.row)">增加</el-button>
                                    <el-button type="success" size="small" @click="showTestDetail(scope.row)">展示</el-button>
                                </template>
                            </el-table-column>
                        </el-table>
                    </el-tab-pane>
                    
                    <el-tab-pane label="测试场景">
                        <div class="hello">
                            <el-table :data="testscene" border @selection-change="handleSelectionChange2">
                                <el-table-column type="selection" width="50px"></el-table-column>
                                <el-table-column  size="small" type="index" width="80"></el-table-column>
                                <!-- <el-table-column prop="id" label="序号" size="small" min-width="10%"></el-table-column> -->
                                <el-table-column prop="TestSuite" label="场景名称" width="160"></el-table-column>
                                <el-table-column label="执行进度" width="160">
                                    <template scope="scope">
                                        <el-progress :text-inside="true" :stroke-width="18" :percentage="100" status="success"></el-progress>
    
                                    </template>
    
                                </el-table-column>
                                <el-table-column label="操作" width="400">
    
                                    <template scope="scope">
                                        <el-button type="danger" size="small" @click="deltestdata11(scope.$index,scope.row)">删除</el-button>
                                        <el-button type="primary" size="small" @click="runtestscene()">执行</el-button>
                                        <el-button type="warning" size="small" @click="runtestscene()">执行详情</el-button>
    
                                    </template>
    
                                </el-table-column>
                            </el-table>
    
                        </div>
                        <div class="totalDiv">
                            <el-button type="success" size="small" min-width="30%" @click="runAll()">全部运行</el-button>
                        </div>
                    </el-tab-pane>
                    <!-- <el-tab-pane label="测试结果">
                            <el-progress :text-inside="true" :stroke-width="18" :percentage="0"></el-progress>
                            <el-progress :text-inside="true" :stroke-width="18" :percentage="70"></el-progress>
                            <el-progress :text-inside="true" :stroke-width="18" :percentage="100" status="success"></el-progress>
                            <el-progress :text-inside="true" :stroke-width="18" :percentage="50" status="exception"></el-progress>
                        </el-tab-pane> -->
                </el-tabs>
            </el-col>
            <el-col id="order-list11111" :span="12" v-if="testProgress===true">
                <collapse></collapse>
            </el-col>
            <el-col id="order-list" :span="12" v-show="showRight">
                <div class="often-goods">
                    <div class="title">主键定位
                        
                        <el-button type="warning" size="small" class="save" @click="save">保存当前</el-button>
                    </div>
                    <div class="often-goods-list">
                        <ul>
                            <li>
                                <i>id: </i>
                                <input class="o-price" disabled=true v-model="oftenGoods.id" />
                            </li>
                            <li>
                                <i>name: </i>
                                <input class="o-price" disabled=true v-model="oftenGoods.name" />
                            </li>
                            <li>
                                <i>desc: </i>
                                <input class="o-price " v-model="oftenGoods.desc" />
                            </li>
                        </ul>
                    </div>
                    <div class="title">输入值</div>
                    <div class="often-goods-list">
                        <ul>
                            <li v-for="(key,value) in oftenGoods.input">
                                <i>{{value}}:
                                    <input class="o-price" v-model="oftenGoods.input[value]
                                                    "></input>
                                </i>
    
                            </li>
                        </ul>
                    </div>
                    <div class="title">输出结果</div>
                    <div class="often-goods-list">
                        <ul>
                            <li v-for="(key,value) in oftenGoods.expectResult">
                                <i>{{value}}:
                                    <input class="o-price" v-model="oftenGoods.expectResult[value]" /> </i>
                            </li>
                        </ul>
                    </div>
                </div>
                
            </el-col>
        </el-row>
       
        <div>
           <div  class="newinterface" v-show="InterfaceFlag" >
            <addInterface :testdata="mydata1.testdata"></addInterface>
           </div>
            <div class="addtestList-wrapper" v-show="fold">
                <div class="title">
                    <span class="suitesize">添加到场景</span>
                    <el-button type="success" size="small" class="dialog" @click="dialogFormVisible = true">添加新的测试集合</el-button>
    
                    <el-dialog title="集合" :visible.sync="dialogFormVisible">
                        <el-form :model="form">
                            <el-form-item label="集合名称" :label-width="formLabelWidth">
                                <el-input v-model="form.TestSuite" auto-complete="off"></el-input>
                            </el-form-item>
                            <el-form-item label="集合描述" :label-width="formLabelWidth">
                                <el-input v-model="form.TestSuiteDesc" auto-complete="off"></el-input>
                            </el-form-item>
                            <el-form-item label="测试用例" :label-width="formLabelWidth">
                                <el-input v-model="form.TestSuiteData" auto-complete="off"></el-input>
                            </el-form-item>
    
                        </el-form>
                        <div slot="footer" class="dialog-footer">
                            <el-button @click="dialogFormVisible = false">取 消</el-button>
                            <el-button type="primary" @click="addnewTestsuite()">确 定</el-button>
                        </div>
                    </el-dialog>
                    <el-button type="warning" size="small" class="save" @click="quit()">退出</el-button>
                </div>
                <el-row>
                    <el-col id="order-list" :span="12" class="pos-order">
                        <el-tabs>
                            <!-- <!--  -->
                            <el-card height="100px" class="box-card1s">
                           <div class='text item'>用例集:
                                <span class="userlogininfo">{{testSuite.name}}</span>
                            </div>
                             <div class='text item'>回调函数:
                                <span class="userlogininfo">{{mydata1.spi}}</span>
                            </div>
                             <div class='text item'>系统:
                                <span class="userlogininfo">{{mydata1.system}}</span>
                            </div>
                            </el-card>
                            <div class="title">
                                <span class="suitesize">场景集合
                                     <el-button type="warning" size="small" @click="selectadd()">批量添加选择测试场景</el-button>
                                </span>
                            </div>
                            <el-table :data="testSuite.data"  border  @selection-change="handleSelectionChange" >
                                <el-table-column type="selection" width="40px">
                                    
                                </el-table-column>
                                <el-table-column type="index" width="40px"></el-table-column>
                                <!-- <el-table-column prop="id" label="序号" size="small" min-width="10%"></el-table-column> -->
                                <el-table-column prop="TestSuite" label="场景名称" width="120px"></el-table-column>
                                <el-table-column prop="TestSuiteDesc" size="small" label="场景描述" width="240px"></el-table-column>
                                <el-table-column label="操作" width="330px">
                                    <template scope="scope">
                                        <el-button type="danger" size="small" @click="addtestscene(scope.row)">组合</el-button>
                                        <el-button type="primary" size="small" @click="deletescenedata(scope.$index, scope.row)">删除</el-button>
                                         <el-button type="warning" size="small" @click="addSuiteList(scope.row)">增加</el-button>
                                        <el-button type="success" size="small" @click="showTestSuiteDetail(scope.row)">展示</el-button>
                                    </template>
                                </el-table-column>
                            </el-table>
                            <div class="title">
                                <span class="suitesize">场景用例展示集合</span>
                            </div>
                            <el-table :data="testSuiteDetails" border>
                                <el-table-column type="index" width="60px"></el-table-column>
                                <el-table-column prop="id" label="序号" sortable size="small" width="60px"></el-table-column>
                                <el-table-column prop="name" label="接口名称" sortable width="200px"></el-table-column>
                                <el-table-column prop="desc" size="small" label="场景描述" width="240px"></el-table-column>
                                <el-table-column label="操作" width="330px">
                                    <template scope="scope">
                                        <el-button type="success" size="small" @click="deltestcase(scope.$index, scope.row)">删除</el-button>
                                        <el-button type="warning" size="small" @click="showTestDetail1(scope.row)">展示</el-button>
                                    </template>
                                </el-table-column>
                            </el-table>
    
                        </el-tabs>
                    </el-col>
                     
                    <el-col id="order-list" :span="12" v-show="show2Right">
                        <div class="often-goods">
                            <div class="title">主键定位
                               
                            </div>
                            <div class="often-goods-list">
                                <ul>
                                    <li>
                                        <i>id: </i>
                                        <input class="o-price" disabled=true v-model="often2Goods.id" />
                                    </li>
                                    <li>
                                        <i>name: </i>
                                        <input class="o-price" disabled=true v-model="often2Goods.name" />
                                    </li>
                                    <li>
                                        <i>desc: </i>
                                        <input class="o-price " v-model="often2Goods.desc" />
                                    </li>
                                </ul>
                            </div>
                            <div class="title">输入值</div>
                            <div class="often-goods-list">
                                <ul>
                                    <li v-for="(key,value) in often2Goods.input">
                                        <i>{{value}}:
                                            <input class="o-price" v-model="often2Goods.input[value]
                                                    "></input>
                                        </i>
    
                                    </li>
                                </ul>
                            </div>
                            <div class="title">输出结果</div>
                            <div class="often-goods-list">
                                <ul>
                                    <li v-for="(key,value) in often2Goods.expectResult">
                                        <i>{{value}}:
                                            <input class="o-price" v-model="often2Goods.expectResult[value]" /> </i>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </el-col>
                </el-row>
            </div>
        </div>
    </div>
</template>
<script>
import axios from 'axios'
import Vue from 'vue'
import collapse from '../common/collapse.vue'
import addInterface from '../common/addInterface.vue'
export default {
    name: 'Pos',
    data() {
        return {
            selectexeScene: [],
            selectaddtest: [],
            selectaddTestSuite:[],
            InterfaceFlag: false,
            dynamicValidateForm: {domains: [{ value: ''}],email: ''},
            testProgress: false,
            dialogFormVisible: false,
            dialogTableVisible: false,

            form: {
                TestSuite: '',
                TestSuiteDesc: '',
                id: '',
                TestSuiteData: ''
            },
            formLabelWidth: '120px',
            input: '',
            testscene: [],
            index: 0,
            showRight: false,
            show2Right: false,
            testSuiteClick: [],
            testSuiteDetails: [],
            testSuite:
            { },
            testcasedata: [],
            fold: false,
            interface1: {
          id:'',
          casename:'',
          casedesc:'',
          caseinput:'',
          caseexpectResult:''

        },
            mydata1: {},
            tableData: [],
            totalMoney: 0,
            totalCount: 0,
            type0Goods: [],
            type1Goods: [],
            type2Goods: [],
            type3Goods: [],
            oftenGoods: [],
            often2Goods: [],
            scene: {
              id:'',
              TestSuite:'',
              TestSuiteDesc:'',
              TestSuiteData:'',
              },

        }
         
    },
    created() {
        // axios.get('http://jspang.com/DemoApi/oftenGoods.php').then(reponse => {
        //     this.oftenGoods = reponse.data
        // })
        //     .catch(error => {
        //         console.log(error)
        //         alert('网络错误')
        //     })

       axios.get('http://localhost:8081/myapp/mvc/selectAll.do', { headers: { 'X-Requested-With': 'XMLHttpRequest' } }).then(response => {
           this.mydata1 = response.data
           
       }),
       axios.get('http://localhost:8081/myapp/testscene/selectAll.do', { headers: { 'X-Requested-With': 'XMLHttpRequest' } }).then(response => {
           this.testSuite = response.data
           
       }),


       //     .catch(error => {
       //         console.log(error)
      //          alert('网络错误')
      //      })
        axios.get('http://jspang.com/DemoApi/typeGoods.php').then(reponse => {
            this.type0Goods = reponse.data[0]
            this.type1Goods = reponse.data[1]
            this.type2Goods = reponse.data[2]
            this.type3Goods = reponse.data[3]
        })
            .catch(error => {
                console.log(error)
                alert('网络错误')
            })
    },
    mounted: function () {
        var orderHeight = document.body.clientHeight
        document.getElementById('order-list').style.height = orderHeight + 'px'
    },
    methods: {
       handleSelectionChange1(val){
           this.selectaddtest=val
       },
       handleSelectionChange(val) {
       this.selectaddTestSuite = val
       },
       handleSelectionChange2(val){
           this.selectexeScene=val
       },
     getNowFormatDate() {
    var date = new Date();
    var seperator1 = "-";
    var seperator2 = ":";
    var month = date.getMonth() + 1;
    var strDate = date.getDate();
    if (month >= 1 && month <= 9) {
        month = "0" + month;
    }
    if (strDate >= 0 && strDate <= 9) {
        strDate = "0" + strDate;
    }
    var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate
            + " " + date.getHours() + seperator2 + date.getMinutes()
            + seperator2 + date.getSeconds();
    return currentdate;
},
       runAll(){
           var that=this
          let s=new String(this.selectexeScene[0].id)
          if(this.selectexeScene.length>1){
              
          for(var i=1;i<this.selectexeScene.length;i++){
               s=s.concat(",").concat(this.selectexeScene[i].id)
               
               }
          }
         
          let m={
              ids:s,
              time: that.getNowFormatDate()
          }
        axios.post('http://localhost:8081/myapp/exResults/add.do', m, {
                      headers: {
                           'X-Requested-With': 'XMLHttpRequest',
                           
                      }
                  })
                  .then(function (response) {
                    
                     })
                  .catch(function (error) {
                    console.log(error);
                  })
            

        this.$nextTick(function () {

            })
       },
       selectadd(){
          for(var i=0;i<this.selectaddTestSuite.length;i++){
               this.testscene.push(this.selectaddTestSuite[i])
          }
         
            this.$nextTick(function () {

            })
       },
       addInterfaceFlag(){
           this.InterfaceFlag=!this.InterfaceFlag
           this.$nextTick(function () {
           })
       },
       submitForm(formName) {
        this.$refs[formName].validate((valid) => {
          if (valid) {
            alert('submit!');
          } else {
            console.log('error submit!!');
            return false;
          }
        });
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
      },
       handleClick(tab, event) {
       this.testProgress=false
       this.showRight=false
       this.InterfaceFlag=false
      },
        runtestscene() {
           this.showRight=false
           this.show2Right=false
            this.testProgress = true
            this.$nextTick(function () {
                console.log("aaaaaaaaaaaaa")
            })
        },
        addnewTestsuite() {
            var that=this
            this.scene.id="",
            this.scene.TestSuite=this.form.TestSuite
            this.scene.TestSuiteDesc=this.form.TestSuiteDesc
            this.scene.TestSuiteData=this.form.TestSuiteData
            // this.testSuite.data.push(testSuite)
            axios.post('http://localhost:8081/myapp/testscene/add.do', this.scene, {
                      headers: {
                           'X-Requested-With': 'XMLHttpRequest',
                           
                      }
                  })
                  .then(function (response) {
                   that.updatescene()
                  })
                  .catch(function (error) {
                    console.log(error);
                  });
            this.$nextTick(function () {
                //  console.log(this.$el.textContent.olddata)

                // this.testSuiteDetails = this.testSuiteClick
                //  window.location.reload();
            })
            this.$nextTick(function () {
                this.dialogFormVisible = false
            })


        },
        showTestSuiteDetail(testSuite) {
            this.testSuiteClick=testSuite
            let s={
                ids:testSuite.TestSuiteData
            }
            
            axios.post('http://localhost:8081/myapp/mvc/selectMulIds.do', s,{ headers: { 'X-Requested-With': 'XMLHttpRequest' } }).then(response => {
            
            this.testSuiteDetails = response.data
            

           
       })
           
        },
       
        save() {
            
            this.interface1.id=this.oftenGoods.id
            this.interface1.casename=this.oftenGoods.name
            this.interface1.casedesc=this.oftenGoods.desc
            this.interface1.caseinput=this.oftenGoods.input
            this.interface1.caseexpectResult=this.oftenGoods.expectResult
            axios.post('http://localhost:8081/myapp/mvc/update.do', this.interface1, {
                      headers: {
                           'X-Requested-With': 'XMLHttpRequest',
                           
                      }
                  })
                  .then(function (response) {
                    console.log(response);
                  })
                  .catch(function (error) {
                    console.log(error);
                  });
       this.$nextTick(function () {
               
            })
           

        },

        addSuiteList(testSuiteFocus) {
           
           var that=this
           this.testSuiteClick = testSuiteFocus     
           var variable1=this.testSuiteClick.TestSuiteData
           if (variable1 !== '') { 
            if(this.testcasedata.length>=1){
              
              for(let  i=0;i<this.testcasedata.length;i++){
              

               this.testSuiteClick.TestSuiteData=this.testSuiteClick.TestSuiteData.concat(",").concat(this.testcasedata[i].id)
         
               
                }
             }else{
              
             // this.testSuiteClick.TestSuiteData=this.testSuiteClick.TestSuiteData.concat(",").concat(this.testcasedata.id)
              this.testSuiteClick.TestSuiteData=''
              
            }
           }else{
              if(this.testcasedata.length>=1){
                  
                 var s=new String(this.testcasedata[0].id)
                
              for(let  i=1;i<this.testcasedata.length;i++){
              s=s.concat(",").concat(this.testcasedata[i].id)

               
                }
                this.testSuiteClick.TestSuiteData=s
               console.log(this.testSuiteClick.TestSuiteData)
               
             }else{
                 
              //this.testSuiteClick.TestSuiteData=this.testcasedata.id.toString()
              //console.log(this.testSuiteClick.TestSuiteData)
              this.testSuiteClick.TestSuiteData=''

            }
            
        }
          
           axios.post('http://localhost:8081/myapp/testscene/update.do', this.testSuiteClick, {
                      headers: {
                           'X-Requested-With': 'XMLHttpRequest',
                           
                      }
                  })
                  .then(function (response) {
                    console.log(response);
                    that.showTestSuiteDetail(testSuiteFocus)
                  })
                  .catch(function (error) {
                    console.log(error);
                  });
            this.$nextTick(function () {
                //  console.log(this.$el.textContent.olddata)

                // this.testSuiteDetails = this.testSuiteClick
                //  window.location.reload();
            })
        },
        fresh() {
            alert('刷新后台数据成功');
            //this.mydata1 = this.olddata;
            //深度拷贝

            this.mydata1 = JSON.parse(JSON.stringify(this.olddata))
            this.oftenGoods = JSON.parse(JSON.stringify(this.olddata.testdata[this.oftenGoods.id]))
            this.$nextTick(function () {
                
            })

        },
        quit() {
            this.fold = false
            this.show2Right=false
              this.$nextTick(function () {
                
            })

        },
        addselecttestcase(){
            
            if(this.selectaddtest.length===0){
                alert("没有勾选任一case，请返回勾选")
            }else{
            this.testcasedata = this.selectaddtest
            this.fold = true
            }
            
        },
        addList(testCase) {
             
            this.testcasedata = testCase
            this.fold = true

        },
        updatedate() {
           axios.get('http://localhost:8081/myapp/mvc/selectAll.do', { headers: { 'X-Requested-With': 'XMLHttpRequest' } }).then(response => {
           this.mydata1 = response.data
           
       }),
            this.$nextTick(function () {

            })
        },
        addOrderList(goods) {
            this.totalMoney = 0
            this.totalCount = 0
            let isHave = false
            for (let i = 0; i < this.tableData.length; i++) {
                if (this.tableData[i].goodsId === goods.goodsId) {
                    isHave = true
                }
            }
            if (isHave) {
                let arr = this.tableData.filter(o => o.goodsId === goods.goodsId)
                arr[0].count++
            } else {
                let newGoods = { goodsId: goods.goodsId, goodsName: goods.goodsName, price: goods.price, count: 1 }
                this.tableData.push(newGoods)
            }
            this.tableData.forEach((element) => {
                this.totalCount += element.count
                this.totalMoney = this.totalMoney + element.count * element.price
            })
        },
        showTestDetail(testCase) {
            this.showRight = true
            this.oftenGoods = testCase


        },
        showTestDetail1(testCase) {
            this.show2Right = true
            this.often2Goods = testCase


        },
        search(input) {
            let test = []
            this.mydata1.testdata.forEach(
                function (val, index, arr) {
                    if (arr[index].name.indexOf(input) !== -1) {

                        test.push(arr[index])
                    }

                }



            )
            console.log(test.length)
            this.mydata1.testdata = test
            this.$nextTick(function () {

            })

        },
        deltestdata11(index, testcase) {
            console.log(index)
            this.testscene.splice(index, 1)
            this.$nextTick(function () {

            })

        },
        updatescene(){
            axios.get('http://localhost:8081/myapp/testscene/selectAll.do', { headers: { 'X-Requested-With': 'XMLHttpRequest' } }).then(response => {
           this.testSuite = response.data
           
       }),
          this.$nextTick(function () {

            })
        },
        deletescenedata(index, testscene){
            var that=this 
            axios.post('http://localhost:8081/myapp/testscene/delete.do', testscene.id, {
                      headers: {
                           'X-Requested-With': 'XMLHttpRequest',
                           
                      }
                  })
                  .then(function (response) {
                    console.log(this);
                     that.updatescene()
                     let s={
                ids:"0"
            }
            
            axios.post('http://localhost:8081/myapp/mvc/selectMulIds.do', s,{ headers: { 'X-Requested-With': 'XMLHttpRequest' } }).then(response => {
            
            that.testSuiteDetails = response.data
            

           
       })
                     })
                  .catch(function (error) {
                    console.log(error);
                  })
                   this.$nextTick(function () {
               
            })
        },
        deltestdata(index, testcase) {
            var that=this
            axios.post('http://localhost:8081/myapp/mvc/delete.do', testcase.id, {
                      headers: {
                           'X-Requested-With': 'XMLHttpRequest',
                           
                      }
                  })
                  .then(function (response) {
                    console.log(this);
                     that.updatedate()
                     })
                  .catch(function (error) {
                    console.log(error);
                  })
            

        },
        addtestscene(testsuite) {
            this.testscene.push(testsuite)
            this.$nextTick(function () {

            })

        },
        deltestcase(index, testcase) {
            var that=this
           console.log(this.testSuiteClick.TestSuiteData)
           var ss=this.testSuiteClick.TestSuiteData.split(",")
           ss.splice(index,1)
           this.testSuiteClick.TestSuiteData=ss.toString()
           axios.post('http://localhost:8081/myapp/testscene/update.do', this.testSuiteClick, {
                      headers: {
                           'X-Requested-With': 'XMLHttpRequest',
                           
                      }
                  })
                  .then(function (response) {
                    console.log(response);
                    that.showTestSuiteDetail(that.testSuiteClick)
                  })
                  .catch(function (error) {
                    console.log(error);
                  });
            this.$nextTick(function () {
               
            })
            console.log(this.testSuiteDetails)
            
            if (this.testSuiteDetails.length === 0) {
                this.show2Right = false
            }
            if (testcase.id != this.often2Goods.id) {
                return;
            } else {
                this.show2Right = false
            }

            this.$nextTick(function () {

            })

        },
        deleteAllGoods() {
            this.tableData = []
            this.totalMoney = 0
            this.totalCount = 0
        }
    },
    components: {
       collapse,
       addInterface
    }
}
</script>
<style>
.text {
    font-size: 14px;
  }
  .el-card__header {
    padding: 5px 10px;
    border-bottom: 1px solid #d1dbe5;
    box-sizing: border-box;
}
.el-card__body {
    padding: 5px;
}
.item {
    padding: 5px 0;
  }

.clearfix:before,
.clearfix:after {
      display: table;
      content: "";
  }
.clearfix:after {
      clear: both
  }

.box-card {
    height: 200px;
    width: 700px;
  }
.box-card1 {
    height: 100px;
    width: 700px;
  }
.pos-order {
    background-color: #F9FAFC;
    
}

.div-btn {
    text-align: center;
    margin-top: 10px
}

.title {
    height: 20px;
    border-bottom: 5px solid #5599FF;
    background-color: #F9FAFC;
    padding: 10px;
}

.often-goods-list ul li {
    list-style: none;

    border: 1px solid #F9FAFC;
    padding: 10px;
    margin: 10px;
    background-color: #FFF;
}

.o-price {
    color: #5887FF
}









.totalDiv {
    text-align: center;
    background: #fff;
    padding: 10px;
    border-bottom: 1px solid #E5E9F2;
}

.userinfo {
    font-size: 16px;
    background-color: #fff;
    font-weight: 700;
    border-bottom: 1px solid #E5E9F2;
}

.userlogininfo {
    font-weight: 200;
    margin: 0 500 0 0;
    color: red;
    vertical-align: center;
}

.idsize {
    font-size: 10px;
    color: green;
}

.save {
    position: absolute;
    right: 50px;
}

/* .el-table::after{
     content:"."; display:block; height:0; visibility:hidden; clear:both; 
}
.el-tabs__active-bar {
    visibility:hidden; clear:both; 
} */

.addtestList-wrapper {
    position: fixed;
    z-index: 9999;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    overflow: auto;
    background: rgba(7, 17, 27, 0.8);
    border-bottom: 1px solid #D3dce6;
    background-color: #F9FAFC;
}

.suitesize {
    font-size: 20px;
    font-weight: 700;
}

.filter {
    width: 100%;
    height: 50px;
    background: rgba(7, 17, 27, 0.8);
    border-bottom: 1px solid #D3dce6;
    background-color: #F9FAFC;
}

.input {
    width: 200px;
    padding: 10px 0 5px 20px;
}

.searchbutton {
    padding: 10px 10px 5px 10px
}

.dialog {
    position: absolute;
    right: 150px;
}
</style>
