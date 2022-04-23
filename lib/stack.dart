class Stk{
  var node=[];
  int size=0;
  push(var data){
    size++;
    node.add(data);
  }
  pop(){
    if(size>0)
      {
        size--;
        return node.removeAt(size);
      }
  }
  dynamic peek()
  {
    if(size>0)
    {
      return node.elementAt(size-1);
    }
  }
  bool isEmpty(){
    if(size==0)
      {
        return true;
      }return false;
  }
  clear(){
    node.clear();
  }
}