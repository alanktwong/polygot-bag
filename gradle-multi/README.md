A multi-project Gradle build
=============================

Always consult the [Gradle user guide](http://www.gradle.org/docs/current/userguide/userguide.html)

Assumptions

- Java 1.7
- Gradle 2.1
- Ant 1.9.3
- Groovy 2.3.6

To generate files for an IDE, use the usual `eclipse` or `idea` tasks.

The modules for this multi-project build are:

1. `shared`: shared across all projects
2. `api`: public API
3. `services/commons`: 
4. `services/webservice`: exposes services
