#pragma once
#include <crtdbg.h>
#include <CppUnitTest.h>

namespace mstest_util {
#ifdef _DEBUG

    struct mem_check_base {
    protected:
        static int get_difference_and_report(_CrtMemState* p_start)
        {
            ::_CrtMemState t_current, t_diff;
            ::_CrtMemCheckpoint(&t_current);
            int t_diff_as_int = ::_CrtMemDifference(&t_diff, p_start, &t_current);
            if( t_diff_as_int != 0 ) {
                ::_CrtMemDumpAllObjectsSince(&t_diff);
            }
            return t_diff_as_int;
        }

        static _CRT_DUMP_CLIENT exchange_dump_client(_CRT_DUMP_CLIENT p_new_dump_client)
        {
            return ::_CrtSetDumpClient(p_new_dump_client);
        }

        mem_check_base() {}
        ~mem_check_base() {}
    };

    class tracked_crt_mem_check : public mem_check_base {
        ::_CrtMemState m_start;
        //_CRT_DUMP_CLIENT m_old_dump_client;
    public:
        tracked_crt_mem_check() 
        {
            //m_old_dump_client = exchange_dump_client([](void* p_block, std::size_t p_block_size) {});
        }

        void start()
        {
            ::_CrtMemCheckpoint(&m_start);
        }

        void finish()
        {
            Microsoft::VisualStudio::CppUnitTestFramework::Assert::AreEqual(0, 
                get_difference_and_report(&m_start), L"Memory leaks detected!");
            //if (m_old_dump_client) {
            //    exchange_dump_client(m_old_dump_client);
            //}
        }
    };

    class scoped_crt_mem_check : public mem_check_base {
        ::_CrtMemState m_start;
        //_CRT_DUMP_CLIENT m_old_dump_client;
    public:
        scoped_crt_mem_check()
        {
            //m_old_dump_client = mem_check::exchange_dump_client([](void* p_block, std::size_t p_block_size) {});
            ::_CrtMemCheckpoint(&m_start);
        }

        ~scoped_crt_mem_check()
        {
            Microsoft::VisualStudio::CppUnitTestFramework::Assert::AreEqual(0, 
                get_difference_and_report(&m_start), L"Memory leaks detected!");
            //exchange_dump_client(m_old_dump_client);
        }
    };

#define MSTEST_UTILS_SCOPED_MEM_CHECK() ::mstest_utils::scoped_crt_mem_check t_crt_mem_check__
#define MSTEST_UTILS_TRACKED_MEM_CHECK() ::mstest_utils::tracked_crt_mem_check m_crt_mem_check__
#define MSTEST_UTILS_TRACKED_MEM_CHECK_START() this->m_crt_mem_check__.start()
#define MSTEST_UTILS_TRACKED_MEM_CHECK_FINISH() this->m_crt_mem_check__.finish()

#else

    class tracked_crt_mem_check {
    public:
        void start() {}
        void finish() {}
    };

    class scoped_crt_mem_check {};

#define MSTEST_UTILS_SCOPED_MEM_CHECK()
#define MSTEST_UTILS_TRACKED_MEM_CHECK()
#define MSTEST_UTILS_TRACKED_MEM_CHECK_START()
#define MSTEST_UTILS_TRACKED_MEM_CHECK_FINISH()

#endif
}