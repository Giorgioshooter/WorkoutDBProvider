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
    func getWorkouts() throws -> [WorkoutEntity] {
        return try serviceLocator.getWorkoutUseCase.getWorkouts()
    }
    
    func getWorkout(withId workoutId:String) throws -> WorkoutEntity {
        return try serviceLocator.getWorkoutByIdUseCase.getWorkout(id: workoutId)
    }
    
    func createWorkout(with workout:WorkoutEntity) throws {
        try serviceLocator.updateWorkoutUseCase.addWorkout(workout: workout)
    }
    
    func updateWorkout(with workout:WorkoutEntity) throws {
        try serviceLocator.updateWorkoutUseCase.updateWorkout(workout: workout)
    }
    
    
    func getExercises(fromWorkoutId workoutId: String) throws -> [ExerciseEntity] {
        return try serviceLocator.getExercisesUseCase.getExercise(workoutId: workoutId)
    }
    
    func updateExercise(with exercise:ExerciseEntity) throws {
        try serviceLocator.updateExerciseUseCase.update(exercise: exercise)
    }
    
    func createExercise(with name:String, workoutId: String, weightsIncluded: Bool = true) throws{
        try serviceLocator.createExerciseUseCase.create(with: name,
                                                        workoutId: workoutId,
                                                        weightsIncluded: weightsIncluded)
    }
    
    func getExercise(withId exerciseId:String) throws -> ExerciseEntity {
        return try serviceLocator.getExerciseByIdUseCase.getExercise(exerciseId: exerciseId)
    }
    
    func addSet(with set:SetEntity) throws {
        try serviceLocator.addSetUseCase.addSet(setEntity: set)
    }
    
    func getSets(withExerciseId exerciseId: String) throws -> [SetEntity] {
        return try serviceLocator.getSetsUseCase.getSets(exerciseId: exerciseId)
    }
    
    func removeWorkout(withId id: String)  {
        serviceLocator.removeWorkoutUseCase.removeWorkout(id: id)
    }
    
    func removeExercise(withId id: String) throws {
        try serviceLocator.removeExerciseUseCase.removeExercise(id: id)
    }
    
    func removeSet(withId id:String) throws {
        serviceLocator.removeSetUseCase.removeSet(id: id)
    }
    
}
