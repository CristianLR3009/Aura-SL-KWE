({
    doInit: function(component) {
        var recordId = component.get("v.recordId");
        var action = component.get("c.obtenerCursosCompletados");
        action.setParams({ personalId: recordId });

        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.cursosCompletados", response.getReturnValue());
            } else if (state === "ERROR") {
                var errors = response.getError();
                var message = "Error desconocido";
                if (errors && errors[0] && errors[0].message) {
                    message = errors[0].message;
                }
                component.set("v.errorMessage", message);
            }
        });
        $A.enqueueAction(action);
    }
})
