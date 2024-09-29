import React, { useState } from 'react';
import { ThemeProvider, createTheme } from '@mui/material/styles';
import {
  Box,
  TextField,
  IconButton,
  Typography,
  List,
  ListItem,
  Avatar,
  Paper
} from '@mui/material';
import SendIcon from '@mui/icons-material/Send';
import AttachFileIcon from '@mui/icons-material/AttachFile';

import axios from 'axios'


const theme = createTheme({
  palette: {
    primary: {
      main: '#0E72ED', // Zoom blue
    },
    background: {
      default: '#FFFFFF', // White background
    },
  },
  typography: {
    fontFamily: '"Helvetica Neue", Arial, sans-serif',
  },
});

function App() {
  const [messages, setMessages] = useState([]);
  const [input, setInput] = useState("");

  const handleSend = async () => {
    if (input.trim() !== "") {
      setMessages([...messages, { text: input, sender: 'user' }]);
      setInput("");

      try {
        const response = await axios.get('http://localhost:8000/api/v1/zoomBot', {
          params: { question: input }
        });

        const botMessage = response.data.status;
        console.log(botMessage);

        setMessages(prevMessages => [
          ...prevMessages,
          { text: botMessage, sender: 'bot' }
        ]);

      } catch (error) {
        console.error("Error receiving bot response:", error);
      }

    }
  };

  const handleAttach = event => {
    const file = event.target.files[0];
    if (file) {
      setMessages([...messages, { text: `File attached: ${file.name}`, sender: 'user' }]);
    }
  };

  return (
    <ThemeProvider theme={theme}>
      <Box sx={{ 
        height: '100vh',
        display: 'flex',
        flexDirection: 'column',
        bgcolor: 'background.default',
      }}>
        <Box sx={{ bgcolor: 'primary.main', color: 'white', p: 2 }}>
          <Typography variant="h5">Zoom Chat</Typography>
        </Box>
        <Box sx={{ flexGrow: 1, overflowY: 'auto', p: 2 }}>
          <List>
            {messages.map((message, index) => (
              <ListItem
                key={index}
                sx={{
                  flexDirection: message.sender === 'user' ? 'row-reverse' : 'row',
                  alignItems: 'flex-start',
                  mb: 2,
                }}
              >
                <Avatar
                  sx={{
                    bgcolor: message.sender === 'user' ? 'primary.main' : 'grey.500',
                    mx: 1,
                  }}
                >
                  {message.sender === 'user' ? 'U' : 'B'}
                </Avatar>
                <Paper
                  elevation={1}
                  sx={{
                    maxWidth: { xs: '75%', sm: '70%', md: '60%' },
                    p: 1,
                    bgcolor: message.sender === 'user' ? 'primary.light' : 'grey.100',
                    borderRadius: 2,
                  }}
                >
                  <Typography variant="body1">{message.text}</Typography>
                </Paper>
              </ListItem>
            ))}
          </List>
        </Box>
        <Box sx={{ p: 2, bgcolor: 'grey.100' }}>
          <Box sx={{ display: 'flex', alignItems: 'center' }}>
            <IconButton component="label" sx={{ mr: 1 }}>
              <AttachFileIcon />
              <input type="file" hidden onChange={handleAttach} />
            </IconButton>
            <TextField
              fullWidth
              variant="outlined"
              placeholder="Type your message..."
              value={input}
              onChange={e => setInput(e.target.value)}
              onKeyPress={e => e.key === 'Enter' && handleSend()}
              sx={{ mr: 1 }}
            />
            <IconButton color="primary" onClick={handleSend}>
              <SendIcon />
            </IconButton>
          </Box>
        </Box>
      </Box>
    </ThemeProvider>
  );
}

export default App;