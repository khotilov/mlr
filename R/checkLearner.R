# props checks if Learner has one or more properties specified in props as a
# character vector.

checkLearner = function(learner, type = NULL, props = NULL) {
  if (is.character(learner))
    learner = makeLearner(learner)
  else
    assertClass(learner, classes = "Learner")

  if (!is.null(type) && learner$type %nin% type) {
    stopf("Learner '%s' must be of type '%s', not: '%s'", learner$id, collapse(type), learner$type)
  }

  if (!is.null(props)) {
    learner.props = getLearnerProperties(learner)
    missing.props = setdiff(props, learner.props)
    if (length(missing.props) > 0L){
      stopf("Learner '%s' must support properties '%s', but does not support '%s'.", learner$id, collapse(props), collapse(missing.props))
    }
  }

  return(learner)
}


# FIXME: this is a deprecated function, which is only need RBPCurve, needs to be removed soon, see #1351
checkLearnerClassif = function(learner, props = NULL) {
  checkLearner(learner, type = "classif", props = props)
}

