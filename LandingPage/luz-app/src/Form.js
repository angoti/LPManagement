import { useState } from "react";
import { useCheckbox, useForm, useInput } from "lx-react-form";
import { Navigate } from 'react-router-dom';

const Form = () => {

    const [submitted, setSubmitted] = useState(false);

    const name = useInput({
        name: "nome",
        errorText: {
            required: "Este campo é obrigatório"
        }
    });

    const email = useInput({
        name: "email",
        validation: "email",
        errorText: {
            required: "Este campo é obrigatório"
        }
    });

    const phone = useInput({
        name: "telefone",
        validation: "telefone",
        mask: "telefone",
        errorText: {
            required: "Este campo é obrigatório"
        }
    });

    const terms = useCheckbox({
        name: "terms",
        errorText: {
            required: "O aceite aos termos é obrigatório para continuar"
        }
    });

    const form = useForm({
        clearFields: true,
        formFields: [name, email, phone, terms],
        submitCallback: (formData) => {
            sendForm(formData);
        },
    });

    const sendForm = (form) => {
        const newForm = {
            "nome": form.nome,
            "email": form.email,
            "telefone": form.telefone.replace(/[^0-9]+/g, '')
        }
        console.log(newForm);
        fetch('https://localhost/cliente', {
            method: 'POST',
            body: JSON.stringify(newForm),
            headers: {
                'Content-Type': 'application/json'
            }
        })
            .then(function (response) {
                if (response.ok) setSubmitted(true);
            })
            .catch(function (err) { console.error(err); });
    }

    function preventDefault(e) {
        e.preventDefault();
        form.handleSubmit(e);
    }

    return (
        <div>
            {submitted ? (
                <Navigate to="/thankyou" replace="true" />
            ) : (

                <div id="form" className="form" name="form">

                    <form onSubmit={preventDefault}>
                        <h2>CONTATO</h2>
                        <h3>Preencha o formulário ao lado que entraremos em contato o mais rápido possível.</h3>
                        <input style={name.error ? {
                            backgroundColor: "rgba(163,55,84,0.4)"
                        } : {}} placeholder='Seu nome' type="text" {...name.inputProps} />
                        <div style={name.error ? { opacity: "1" } : { opacity: "0" }}>
                            {name.error && (name.error)}.</div>

                        <input style={email.error ? {
                            backgroundColor: "rgba(163,55,84,0.4)", color: "#ffff"
                        } : {}} placeholder='Seu melhor e-mail' type="email" {...email.inputProps} />
                        <div style={email.error ? { opacity: "1" } : { opacity: "0" }}>{email.error && (email.error)}.</div>

                        <input style={phone.error ? {
                            backgroundColor: "rgba(163,55,84,0.4)"
                        } : {}} placeholder='Telefone (WhatsApp)' type="tel" {...phone.inputProps} />
                        <div style={phone.error ? { opacity: "1" } : { opacity: "0" }}>{phone.error && (phone.error)}.</div>


                        <label htmlFor={terms.name} className="cont">

                            <input type="checkbox" {...terms.inputProps} />
                            <span className="checkmark"></span>
                            <span>Eu aceito os termos e condições</span>
                            {/* <span>Eu aceito os <Link to="/terms">termos e condições</Link>.</span> */}
                        </label>
                        <div style={terms.error ? { opacity: "1" } : { opacity: "0" }}>{terms.error && (terms.error)}.</div>

                        <button type="submit" >Enviar</button>
                    </form>
                </div>
            )
            }

        </div>
    );

}

export default Form;