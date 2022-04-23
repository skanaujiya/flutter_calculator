import 'package:flutter/material.dart';
import 'custom_button.dart';
import 'stack.dart';

void main() {
  runApp(MyHome());
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Calculator',
    theme: ThemeData(
      primaryColor: Colors.blueAccent,
    ),
    home: Home(),
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String history="";
  String textToDisplay="";
  String res="";
  var list=[];
  Map<String,int> map= {'/':4,'X':3,'+':1,'-':2};
  Stk stack1=Stk();
  Stk stack2=Stk();
  void btnOnClick(String btnValue)
  {
    if(btnValue=='AC')
      {
        history='';
        textToDisplay='';
        res="";
        list.clear();
        stack2.clear();
        stack1.clear();
      }else if(btnValue=='C')
        {
          if(res.isEmpty && list.isNotEmpty)
            {
              var vr="";
              res=list.elementAt(list.length-2);
              vr+=list.removeAt(list.length-1);
              vr+=list.removeAt(list.length-1);
              history=history.substring(0,history.length-vr.length);
            }else
              {
                if(res.isNotEmpty && res[0]!='='){
                  res=res.substring(0,res.length-1);
                }
              }
        }else if(btnValue=='X'||btnValue=='/'||btnValue=='+'||btnValue=='-')
          {
            if(res.isNotEmpty && res[0]=='=')
              {
                list.clear();
                list.add(res.substring(1));
                list.add(btnValue);
                history=list.elementAt(0)+list.elementAt(1);
                res='';
              }else if(list.isNotEmpty && res.isEmpty){
              list.removeLast();
              list.add(btnValue);
              history=history.substring(0,history.length-1)+btnValue;
            }else if(res.isNotEmpty){
              list.add(res);
              history+=res+btnValue;
              list.add(btnValue);
              res="";
            }
          }else if(btnValue=='=')
            {
              if(res.isNotEmpty && res[0]=='=')
                {
                  res=res.substring(1);
                  stack1.clear();
                  list.clear();
                  history="";
                }else if(res.isNotEmpty){
                list.add(res);
                history+=res;
                res="=";
                for(int i=0;i<list.length;i++)
                {
                  if(list[i]=='X'||list[i]=='/'||list[i]=='+'||list[i]=='-')
                  {
                    if(stack2.isEmpty())
                    {
                      stack2.push(list[i]);
                    }else{
                      while(!stack2.isEmpty() && (map[list[i]]!)<(map[stack2.peek()]!))
                      {
                        var a=stack1.pop();
                        var b=stack1.pop();
                        switch(stack2.pop())
                        {
                          case 'X': stack1.push(b*a);
                          break;
                          case '/': stack1.push(b/a);
                          break;
                          case '+': stack1.push(b+a);
                          break;
                          case '-': stack1.push(b-a);
                          break;
                        }
                      }
                      stack2.push(list[i]);
                    }
                  }else{
                    list[i].toString().contains('.')?stack1.push(double.parse(list[i])):stack1.push(int.parse(list[i]));
                  }
                }
                while(!stack2.isEmpty())
                {
                  var a=stack1.pop();
                  var b=stack1.pop();
                  switch(stack2.pop())
                  {
                    case 'X': stack1.push(b*a);
                    break;
                    case '/': stack1.push(b/a);
                    break;
                    case '+': stack1.push(b+a);
                    break;
                    case '-': stack1.push(b-a);
                    break;
                  }
                }
                res+=stack1.pop().toString();
                textToDisplay=res;
              }
            }else{
      res+=btnValue;
    }
    setState(() {
      textToDisplay=res;
    });
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator"),
        backgroundColor: Colors.red,
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.red),
              child: Center(
                child: Text(
                  "Welcome to Our Calculator",
                  style: TextStyle(color: Colors.white, fontSize: 28),
                ),
              ),
            ),
            const ListTile(
              hoverColor: Colors.red,
              title: Text(
                'All types of calculator',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              leading: Icon(Icons.calculate),
            ),
            ListTile(
              hoverColor: Colors.greenAccent,
              title: const Text('Normal'),
              onTap: () {},
            ),
            ListTile(
              onTap: () {},
              title: const Text('Scientific'),
            )
          ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(right: 10),
                    alignment: Alignment.bottomRight,
                    child: Text(
                      history,
                      style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold,),
                    ),
                  )),
             Container(
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.bottomRight,
                    child:  Text(
                      textToDisplay,
                      style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                    ),
                  ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(name: 'AC',callBack: btnOnClick,),
                  const SizedBox(width: 5,height: 60,),
                  CustomButton(name: 'C',callBack: btnOnClick,),
                  const SizedBox(width: 5,height: 70,),
                  CustomButton(name: '%',callBack: btnOnClick,),
                  const SizedBox(width: 5,height: 70,),
                  CustomButton(name: '/',callBack: btnOnClick,)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(name: '7',callBack: btnOnClick,),
                  const SizedBox(width: 5,height: 80,),
                  CustomButton(name: '8',callBack: btnOnClick,),
                  const SizedBox(width: 5,height: 70,),
                  CustomButton(name: '9',callBack: btnOnClick,),
                  const SizedBox(width: 5,height: 70,),
                  CustomButton(name: 'X',callBack: btnOnClick,size: 15,)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(name: '4',callBack: btnOnClick,),
                  const SizedBox(width: 5,height: 70,),
                  CustomButton(name: '5',callBack: btnOnClick,),
                  const SizedBox(width: 5,height: 70,),
                  CustomButton(name: '6',callBack: btnOnClick,),
                  const SizedBox(width: 5,height: 70,),
                  CustomButton(name: '-',callBack: btnOnClick,size: 25,)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(name: '1',callBack: btnOnClick,),
                  const SizedBox(width: 5,height: 80),
                  CustomButton(name: '2',callBack: btnOnClick,),
                  const SizedBox(width: 5,height: 70,),
                  CustomButton(name: '3',callBack: btnOnClick,),
                  const SizedBox(width: 5,height: 70),
                  CustomButton(name: '+',callBack: btnOnClick,)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(name: '--',callBack: btnOnClick,),
                  const SizedBox(width: 5,height: 60,),
                  CustomButton(name: '0',callBack: btnOnClick,),
                  const SizedBox(width: 5,height: 70,),
                  CustomButton(name: '.',callBack: btnOnClick,size: 22,),
                  const SizedBox(width: 5,height: 70,),
                  CustomButton(name: '=', color: Colors.blueAccent,callBack: btnOnClick,)
                ],
              ),
            ],
          )),
    );
  }
}
