# Modern Java in Action

## Chapter 1

### Concepts

1. Stream Processing
2. Pass behavior to methods via method references
3. Parallelism and shared mutable data

### Functions in Java

Methods can be first class citizens by being passed as a `method reference`:

    var files = new File(".").listFiles(new FileFilter { public boolean accept()... });

becomes:

    var files = newFile(".").listFiles(File::isHidden);

A `predicate` is used in math to mean something that takes in an object and returns a true/false.  An example method accepting a predicate:

    public List<MyObject> filterObjects(List<MyObject> objects, Predicate<MyObject> filter)

### Streams

Streams processing is similar to LINQ in .NET:

    List<Apple> heavyApples1 = inventory.stream()
        .filter((Apple a) -> a.getWeight() > 150)
        .collect(toList());
    List<Apple> heavyApples2 = inventory.parallelStream()
        .filter((Apple a) -> a.getWeight() > 150)
        .collect(toList());

### Default methods on interfaces

When adding a new method to an existing interface, instead of requiring all implementing classes add new code the interface can supply a defaul method:

    interface List {
        default void sort(Comparator<? super E> c) { Collections.sort(this, c);
    }

## Chapter 2

### Behavior Parameterization

Passing in a method reference or lambda to a function to affect behavior is similar to the `strategy pattern`.

## Chapter 3

### Functional interface

A `functional interface` exposes a single method and is suitable for lambda substitution.  For example:

    public interface Predicate<T> {
        boolean test (T t);
    }

    public List<T> filter(Iterable<T> collection, Predicate<T> filter)

    var smallHomes = filter(allHomes, (Home h) -> h.sqFt < 1000);
