///
/// DB that manages workouts.
/// - Authors
///    - Georgios
///    
public struct WorkoutDBProvider {
    public var text = "Your Workout Database provider"
    private let serviceLocator: ServiceLocator
    
    public init() {
        self.serviceLocator = ServiceLocator(entitiesRepo: RealmEntityRepo())
    }
    
    ///
    /// Returns a List of workouts
    ///
    public func getWorkouts() throws -> [WorkoutEntity] {
        return try serviceLocator.getWorkoutUseCase.getWorkouts()
    }
    
    public func getWorkout(withId workoutId:String) throws -> WorkoutEntity {
        return try serviceLocator.getWorkoutByIdUseCase.getWorkout(id: workoutId)
    }
    
    public func createWorkout(with workout:WorkoutEntity) throws {
        try serviceLocator.updateWorkoutUseCase.addWorkout(workout: workout)
    }
    
    public func updateWorkout(with workout:WorkoutEntity) throws {
        try serviceLocator.updateWorkoutUseCase.updateWorkout(workout: workout)
    }
    
    
    public func getExercises(fromWorkoutId workoutId: String) throws -> [ExerciseEntity] {
        return try serviceLocator.getExercisesUseCase.getExercise(workoutId: workoutId)
    }
    
    public func updateExercise(with exercise:ExerciseEntity) throws {
        try serviceLocator.updateExerciseUseCase.update(exercise: exercise)
    }
    
    public func createExercise(with name:String, workoutId: String, weightsIncluded: Bool = true) throws{
        try serviceLocator.createExerciseUseCase.create(with: name,
                                                        workoutId: workoutId,
                                                        weightsIncluded: weightsIncluded)
    }
    
    public func getExercise(withId exerciseId:String) throws -> ExerciseEntity {
        return try serviceLocator.getExerciseByIdUseCase.getExercise(exerciseId: exerciseId)
    }
    
    public func addSet(with set:SetEntity) throws {
        try serviceLocator.addSetUseCase.addSet(setEntity: set)
    }
    
    public func getSets(withExerciseId exerciseId: String) throws -> [SetEntity] {
        return try serviceLocator.getSetsUseCase.getSets(exerciseId: exerciseId)
    }
    
    public func removeWorkout(withId id: String)  {
        serviceLocator.removeWorkoutUseCase.removeWorkout(id: id)
    }
    
    public func removeExercise(withId id: String) throws {
        try serviceLocator.removeExerciseUseCase.removeExercise(id: id)
    }
    
    public func removeSet(withId id:String) throws {
        serviceLocator.removeSetUseCase.removeSet(id: id)
    }
    
}
