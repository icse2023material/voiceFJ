class A extends Object {
  A() { super(); }
}
class B extends Object {
  B() { super(); }
}
class Pair extends Object  {
  Object fst;
  Object snd;
  Pair(Object fst, Object snd) {
    super();
    this.fst = fst;
    this.snd = snd;
}
  Pair swapObject() {
    return new Pair(this.snd, this.fst);
  } 
}
new Pair(new A(), new B()).swapObject()