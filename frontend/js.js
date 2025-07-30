$("#button-blue").on("click", function() {
    var txt_nome = $("#name").val();
    var txt_email = $("#email").val();
    var txt_comentario = $("#comment").val();

    if (!txt_nome || !txt_email || !txt_comentario) {
        alert("Por favor, preencha todos os campos.");
        return;
    }

    $.ajax({
        url: "http://localhost:8080/index.php",
        type: "post",
        data: {nome: txt_nome, comentario: txt_comentario, email: txt_email},
        beforeSend: function() {
            console.log("Tentando enviar os dados....");
            $("#button-blue").prop('disabled', true).text('Enviando...');
        }
    }).done(function(e) {
        alert("Dados Salvos com sucesso.");
        $("#name").val('');
        $("#email").val('');
        $("#comment").val('');
    }).fail(function() {
        alert("Erro ao salvar dados. Tente novamente.");
    }).always(function() {
        $("#button-blue").prop('disabled', false).text('Enviar');
    });
});