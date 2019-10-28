# Enhancements in Java SE 8
source - https://docs.oracle.com/javase/8/docs/technotes/guides/language/enhancements.html#javase8

* [Lambda Expressions](http://docs.oracle.com/javase/tutorial/java/javaOO/lambdaexpressions.html) enable you to encapsulate a single unit of behavior and pass it to other code. You can use a lambda expressions if you want a certain action performed on each element of a collection, when a process is completed, or when a process encounters an error. Lambda expressions are supported by the following features:
  * [Method References](http://docs.oracle.com/javase/tutorial/java/javaOO/methodreferences.html) are compact, easy-to-read lambda expressions for methods that already have a name.
  * [Default Methods](http://docs.oracle.com/javase/tutorial/java/IandI/defaultmethods.html) enable you to add new functionality to the interfaces of your libraries and ensure binary compatibility with code written for older versions of those interfaces. They are interface methods that have an implementation and the `default` keyword at the beginning of the method signature. In addition, you can define static methods in interfaces.
  * [New and Enhanced APIs That Take Advantage of Lambda Expressions and Streams in Java SE 8](https://docs.oracle.com/javase/8/docs/technotes/guides/language/lambda_api_jdk8.html) describe new and enhanced classes that take advantage of lambda expressions and streams.

Improved Type Inference - The Java compiler takes advantage of target typing to infer the type parameters of a generic method invocation. The target type of an expression is the data type that the Java compiler expects depending on where the expression appears. For example, you can use an assignment statement's target type for type inference in Java SE 7. However, in Java SE 8, you can use the target type for type inference in more contexts. The most prominent example is using a method invocation's target types to infer the data types of its arguments.

Consider the following example:

```
List<String> stringList = new ArrayList<>();
stringList.add("A");
stringList.addAll(Arrays.asList());
```

Disregarding generics for the moment, the method `addAll` expects a `Collection` instance as its argument, and the method `Arrays.asList` returns a `List` instance. This works because `List` is a subtype of `Collection`.

Now considering generics, the target type of `addAll` is `Collection<? extends String>`, and `Arrays.asList` returns a `List<T>` instance. In this example, the Java SE 8 compiler can infer that the value of the type variable `T` is `String`. The compiler infers this from the target type `Collection<? extends String>`.

Compilers from Java SE 7 and earlier do not accept this code because they do not use target typing to infer types for method call arguments. For example, the Java SE 7 compiler generates an error message similar to the following:

`error: no suitable method found for addAll(List<Object>) ...
method List.addAll(Collection<? extends String>) is not applicable (actual argument List<Object> cannot be converted to Collection<? extends String> by method invocation conversion)`

Consequently, in situations like this where the Java compiler cannot infer types, you must explicitly specify values for type variables with type witnesses. For example, the following works in Java SE 7:
```
List<String> stringList = new ArrayList<>();
stringList.add("A");
stringList.addAll(Arrays.<String>asList());
```

See the following sections in the Java Tutorials for more information:
  * [Target Typing](http://docs.oracle.com/javase/tutorial/java/javaOO/lambdaexpressions.html#target-typing) in [Lambda Expressions](http://docs.oracle.com/javase/tutorial/java/javaOO/lambdaexpressions.html)
  * [Type Inference](http://docs.oracle.com/javase/tutorial/java/generics/genTypeInference.html)

Annotations on Java Types - It is now possible to apply an annotation anywhere a type is used. Used in conjunction with a pluggable type system, this allows for stronger type checking of your code. For more information, see [Type Annotations and Pluggable Type Systems](http://docs.oracle.com/javase/tutorial/java/annotations/type_annotations.html) in the new [Annotations](http://docs.oracle.com/javase/tutorial/java/annotations/) lesson in the Java Tutorial.

Repeating Annotations - It is now possible to apply the same annotation type more than once to the same declaration or type use. For more information, see [Repeating Annotations](http://docs.oracle.com/javase/tutorial/java/annotations/repeating.html) in the new [Annotations](http://docs.oracle.com/javase/tutorial/java/annotations/) lesson in the Java Tutorial.

Method Parameter Reflection - You can obtain the names of the formal parameters of any method or constructor with the method <code>[java.lang.reflect.Executable.getParameters](https://docs.oracle.com/javase/8/docs/api/java/lang/reflect/Executable.html#getParameters)</code>. (The classes <code>[Method](https://docs.oracle.com/javase/8/docs/api/java/lang/reflect/Method.html)</code> and <code>[Constructor](https://docs.oracle.com/javase/8/docs/api/java/lang/reflect/Constructor.html)</code> extend the class <code>[Executable](https://docs.oracle.com/javase/8/docs/api/java/lang/reflect/Executable.html)</code> and therefore inherit the method `Executable.getParameters`.) However, `.class` files do not store formal parameter names by default. To store formal parameter names in a particular `.class` file, and thus enable the Reflection API to retrieve formal parameter names, compile the source file with the `-parameters` option of the <code>[javac](https://docs.oracle.com/javase/8/docs/technotes/guides/javac/index.html)</code> compiler. See [Obtaining Names of Method Parameters](http://docs.oracle.com/javase/tutorial/reflect/member/methodparameterreflection.html) in the Java Tutorials.
