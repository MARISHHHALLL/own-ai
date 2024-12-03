'use client'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import axios from 'axios'
import { Send } from 'lucide-react'
import { FormEvent, useState } from 'react'
type ChatMessage = {
  type: 'user' | 'assistant'
  message: string
}
export default function Home() {
  const [inputValue, setInputValue] = useState<string>('')
  const [chatLog, setChatLog] = useState<ChatMessage[]>([])
  const handleSubmitChat = (e: FormEvent) => {
    e.preventDefault()
    setChatLog((prev: ChatMessage[]) => [
      ...prev,
      { type: 'user', message: inputValue },
    ])
    sendMessage(inputValue)

    setInputValue('')
  }
  const sendMessage = async (message: string) => {
    const url = 'https://api.openai.com/v1/chat/completions'
    const headers = {
      'Content-type': 'application/json',
      Authorization: `Bearer ${process.env.NEXT_PUBLIC_GPT_API_KEY}`,
    }
    const data = {
      model: 'gpt-4',
      messages: [{ role: 'user', content: message }],
    }
    axios
      .post(url, data, { headers })
      .then((res) =>
        setChatLog((prev) => [
          ...prev,
          { type: 'assistant', message: res.data?.choices[0].message.content },
        ])
      )
  }

  return (
    <div className='max-w-screen-md mx-auto pt-10 h-screen w-full'>
      {chatLog &&
        chatLog.map((message, index) => {
          return (
            <div className='flex flex-col w-full ' key={index}>
              <span
                className={`px-4 py-2  rounded-lg max-w-[50%]  ${
                  message.type === 'user'
                    ? 'self-end bg-primary/10'
                    : 'self-start bg-primary text-white'
                } `}
              >
                {message.message}
              </span>
            </div>
          )
        })}
      <div className='fixed bottom-0 left-0 right-0 max-w-screen-md w-full mx-auto pb-5'>
        <form
          onSubmit={handleSubmitChat}
          className='flex flex-row items-center gap-x-2 '
        >
          <Input
            value={inputValue}
            className=''
            placeholder=''
            type='text'
            onChange={(e) => setInputValue(e.target.value)}
          />
          <Button size={'icon'} type='submit'>
            <Send />
          </Button>
        </form>
      </div>
    </div>
  )
}
