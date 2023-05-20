import { useState } from "react";
import { db } from './service/firebase';
import { collection, addDoc, Timestamp } from 'firebase/firestore';
import { yupResolver } from '@hookform/resolvers/yup';
import * as Yup from 'yup';
import Button from '@mui/material/Button';
import Radio from '@mui/material/Radio';
import RadioGroup from '@mui/material/RadioGroup';
import FormControlLabel from '@mui/material/FormControlLabel';
import FormControl from '@mui/material/FormControl';
import FormLabel from '@mui/material/FormLabel';
import TextField from '@mui/material/TextField';
import { AssignmentInd, Email, Phone } from "@mui/icons-material";
import { Checkbox, Container, Divider, FormHelperText, Stack } from "@mui/material";

const AddClient = () => {

    const [submitted, setSubmitted] = useState(false);
    const [error, setError] = useState(false);
    const [helperText, setHelperText] = useState('');
    const [state, setState] = useState({
        name: "",
        email: "",
        phone: "",
        segment: "bolsas",
        terms: false
    });

    const handleChange = (event) => {
        const { name, value, checked } = event.target;
        if (name === "terms") {
            setState({
                ...state,
                [event.target.name]: checked,
            });
        } else {
            setState({
                ...state,
                [event.target.name]: value,
            });
        }
    };

    const phone = useInput({
        name: "phone",
        validation: "phone",
        mask: "telefone",
        errorText: {
            validation: "Telefone inválido"
        }
    });

    const validation = Yup.object().shape({
        name: Yup.string().min(3, 'O nome precisa ter pelo menos 3 caracteres'),
        phone:
            email: Yup.string()
                .email('O Email digitado é inválido'),
        terms: Yup.bool().oneOf([true], 'Para prosseguir, por favor, aceite os termos.')
    });

    const handleSubmit = async (e) => {
        e.preventDefault()
        if (!terms) {
            setHelperText('Para prosseguir, por favor, aceite os termos.');
            setError(true);
        } else {
            try {
                await addDoc(collection(db, 'clients'), {
                    name: name,
                    email: email,
                    phone: phone,
                    segment: segment,
                    created: Timestamp.now()
                })
                setSubmitted(true)
            } catch (err) {
                alert(err)
            }
        }
    }

    const { name, email, segment, terms } = state;

    return (
        <div>
            {submitted ? (
                <div>Enviado</div>
            ) : (
                <Stack direction={{ sm: 'column', md: 'row' }} useFlexGap="true"
                    spacing={{ xs: 1, sm: 2, md: 1 }} justifyContent="center"
                    alignItems="center" divider={<Divider orientation="vertical" flexItem />}>
                    <Container maxWidth="xs">
                        <h2>CONTATO</h2>
                        <h3>Preencha o formulário ao lado que entraremos em contato o mais rápido possível.</h3>
                    </Container>
                    <Container maxWidth="sm">
                        <form onSubmit={handleSubmit}>
                            <TextField id="outlined-basic" required label="Seu nome" variant="outlined" margin="normal" fullWidth name="name" value={name}
                                onChange={handleChange}
                                InputProps={{ startAdornment: <AssignmentInd /> }} />
                            <TextField id="outlined-basic" label="Seu melhor e-mail" variant="outlined" fullWidth margin="normal" name="email" value={email}
                                onChange={handleChange}
                                InputProps={{ startAdornment: <Email /> }} />
                            <TextField id="outlined-basic" required label="Telefone (WhatsApp)" fullWidth margin="normal" variant="outlined" name="phone" value={phone}
                                onChange={handleChange}
                                InputProps={{
                                    startAdornment: <Phone />
                                }} />
                            <FormControl component="fieldset" fullWidth margin="normal">
                                <FormLabel id="demo-radio-buttons-group-label">Categoria</FormLabel>
                                <RadioGroup
                                    aria-labelledby="demo-radio-buttons-group-label"
                                    row
                                    name="radio-buttons-group"
                                    value={segment}
                                    onChange={handleChange}
                                >
                                    <FormControlLabel value="bolsas" control={<Radio />} label="Bolsas" />
                                    <FormControlLabel value="cintos" control={<Radio />} label="Cintos" />
                                    <FormControlLabel value="carteiras" control={<Radio />} label="Carteiras" />
                                    <FormControlLabel value="bijuterias" control={<Radio />} label="Bijuterias" />
                                </RadioGroup>
                            </FormControl>
                            <FormControl error={error}>
                                <FormControlLabel
                                    control={
                                        <Checkbox
                                            name="terms"
                                            checked={terms}
                                            onChange={handleChange}
                                        />
                                    }
                                    label="Aceito os termos e condições"
                                />
                                <FormHelperText>{helperText}</FormHelperText>
                            </FormControl>
                            <Button fullWidth type="submit" variant="contained">Enviar</Button>
                        </form>
                    </Container>
                </Stack>
            )
            }

        </div >
    );

}

export default AddClient;