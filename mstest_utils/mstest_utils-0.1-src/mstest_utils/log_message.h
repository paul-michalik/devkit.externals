#pragma once
#include <sstream>

namespace mstest_utils {

    template<class TChar>
    class basic_log_message {
        std::basic_stringstream<TChar> m_stream;
    public:
        template<class T>
        std::basic_ostream<TChar>& operator << (T const & p_value)
        {
            return stream() << p_value;
        }

        std::basic_stringstream<TChar>& stream()
        {
            std::basic_stringstream<TChar>().swap(m_stream);
            return m_stream;
        }
    };

    namespace {

        struct as_string_ {};
        static const as_string_ as_string;

        namespace detail {
            template<class TChar>
            class basic_string_proxy {
                std::basic_string<TChar> m_string;
            public:
                operator const TChar* () const
                {
                    return m_string.c_str();
                }

                basic_string_proxy(std::basic_string<TChar> && p_string)
                    : m_string(std::move(p_string)) {}

            };
        }

        template<class TChar>
        detail::basic_string_proxy<TChar> operator | (std::basic_ostream<TChar>& p_out, as_string_ const &)
        {
            return dynamic_cast<std::basic_stringstream<TChar>&>(p_out).str();
        }
    }

    typedef basic_log_message<char> log_message;
    typedef basic_log_message<wchar_t> wlog_message;
}