import { useState } from "react";
import { useCheckbox, useForm, useInput } from "lx-react-form";
import Button from '@mui/material/Button';
import Radio from '@mui/material/Radio';
import RadioGroup from '@mui/material/RadioGroup';
import FormControlLabel from '@mui/material/FormControlLabel';
import FormControl from '@mui/material/FormControl';
import FormLabel from '@mui/material/FormLabel';
import TextField from '@mui/material/TextField';

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
        fetch('https://localhost:8080/cliente', {
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
                <></>
            ) : (
                <div id="form" className="form" name="form">
                    <h2>CONTATO</h2>
                    <h3>Preencha o formulário ao lado que entraremos em contato o mais rápido possível.</h3>
                    <FormControl>
                        <TextField id="outlined-basic" required label="Seu nome" variant="outlined" margin="normal" {...name.inputProps} />
                        <TextField id="outlined-basic" label="Seu melhor e-mail" variant="outlined" margin="normal" {...email.inputProps} />
                        <TextField id="outlined-basic" required label="Telefone (WhatsApp)" margin="normal" variant="outlined" {...phone.inputProps} />
                        <FormLabel id="demo-radio-buttons-group-label">Categoria</FormLabel>
                        <RadioGroup
                            aria-labelledby="demo-radio-buttons-group-label"
                            row
                            defaultValue="bolsas"
                            name="radio-buttons-group"
                        >
                            <FormControlLabel value="bolsas" control={<Radio />} label="Bolsas" />
                            <FormControlLabel value="cintos" control={<Radio />} label="Cintos" />
                            <FormControlLabel value="carteiras" control={<Radio />} label="Carteiras" />
                            <FormControlLabel value="bijuterias" control={<Radio />} label="Bijuterias" />
                        </RadioGroup>
                        <Button variant="contained">Enviar</Button>
                    </FormControl>

                </div>
            )
            }

        </div>
    );

}

export default Form;