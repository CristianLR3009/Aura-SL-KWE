({
    doInit: function(component) {
        var recordId = component.get("v.recordId");
        var action = component.get("c.obtenerCursosCompletados");
        action.setParams({ personalId: recordId });

        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {

                var cursos = response.getReturnValue();
                //component.set("v.cursosCompletados", cursos);

                var cursosConNombre = cursos.map(curso => {
                    return {
                        Id: curso.Id,
                        Name: curso.Curso__r.Name,
                        Fecha_de_inicio__c: curso.Fecha_de_inicio__c,
                        Fecha_de_finalizaci_n__c: curso.Fecha_de_finalizaci_n__c
                    }
                });

                component.set("v.cursosCompletados", cursosConNombre);

                // Definir columnas para el datatable
                component.set("v.columns", [
                    { label: 'Nombre del Curso', fieldName: 'Name', type: 'text' },
                    { label: 'Fecha de Inicio', fieldName: 'Fecha_de_inicio__c', type: 'date' },
                    { label: 'Fecha de Finalización', fieldName: 'Fecha_de_finalizaci_n__c', type: 'date' },
                ]);

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
