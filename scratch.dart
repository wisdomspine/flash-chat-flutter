mixin MixinA {
  void printMessage() {
    print("Hello world A");
  }
}

mixin MixinB on MixinA {
  void printMessage() {
    print("Hello world B");
  }
}

mixin MixinC on MixinA, MixinB {
  void printMessage() {
    print("Hello worldC");
  }
}

class A with MixinA, MixinB, MixinC {}

main(List<String> args) {
  A().printMessage();
}
