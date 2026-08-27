allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

<<<<<<< HEAD
val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
=======
val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
>>>>>>> 7f1b1ee8ae437682cb91dd8b4ab4d45ce3e500f6
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
<<<<<<< HEAD

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
=======
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
>>>>>>> 7f1b1ee8ae437682cb91dd8b4ab4d45ce3e500f6
