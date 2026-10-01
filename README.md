# Workout DB Provider

A small wrapper around SQLite (the system `SQLite3` library, no third-party dependencies) that offers a selection of APIs an application can use to store and retrieve workout data.

```swift
let db = try WorkoutDBProvider()                    // Documents/workouts.sqlite
let db = try WorkoutDBProvider(path: ":memory:")    // throwaway database
```
