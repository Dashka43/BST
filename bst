//#pragma once
#ifndef BST_
#define BST_
#include <string>
#include <vector>
#include <queue>
#include <iostream>
#include <functional>
using namespace std;

template<typename T>
class BST {
public:
    struct Node {
        int  x;
        Node* right;
        Node* left;
        Node* up;
        Node(int d) {
            x = d;
            right = nullptr;
            left = nullptr;
            up = nullptr;
        }
    };
    void in_order(Node* p, function<void(const T&)>& f) const;
    BST<T>& operator=(BST<T>&& obj) {
        this->root = move(obj.root);
        obj.root = nullptr;
        obj.s = 0;
        return *this;
    }
    BST<T>& operator=(const BST<T>& obj)
    {
        queue <Node*> q;


        q.push(root);
        while (!q.empty())
        {
            Node* node = q.front();
            q.pop();

            if (node && node->left != nullptr)
                q.push(node->left);
            if (node && node->right != nullptr)
                q.push(node->right);

            free(node);
        }
        s = 0;


        root = nullptr;

        q.push(obj.root);
        while (!q.empty())
        {
            Node* node = q.front();
            q.pop();

            if (node->left != nullptr)
                q.push(node->left);
            if (node->right != nullptr)
                q.push(node->right);

            push(node->x);
        }
        return *this;
    }
    struct iterator;
    Node* root;
    int s = 0;
    BST<T>();
    ~BST<T>();
    BST<T>(const BST& obj);
    BST<T>(BST<T>&& obj);
    void push(T k);

    int size() const;
    int findmin();
    int findmax();
    iterator getmax() const

    {

        Node* temp = nullptr;
        iterator it(temp);
        return it;

    }

    iterator getmin() const
    {
        Node* temp = root;
        while (temp->left != nullptr) { temp = temp->left; }
        iterator it(temp);
        return it;
    }
    Node* find(const T& k) const {
        Node* temp = root;
        while ((temp != nullptr) && (temp->x != k))
        {
            if (temp->x > k) { temp = temp->left; }
            else { temp = temp->right; }
        }
        if ((temp==nullptr)||(temp->x!=k )) { return nullptr; }
        else return temp;
    };
    int deletemin();
    int deletemax();
    void deletew1(Node* temp);
    void deletezn(T k)
    {
        deletew1(find(k));
    }
    void print()
    {
        print2(root, 5);
        for (int i = 0; i < 50; i++)
            cout << "- ";
        cout << endl;

    }
    void print2(Node* temp, int space)
    {
        space += 10;

        if (temp->right != nullptr)
            print2(temp->right, space);
        cout << endl;
        for (int i = 10; i < space; i++)
            cout << " ";
        cout << temp->x << "\n";
        if (temp->left != nullptr)
            print2(temp->left, space);
    }
    static void copyd( const BST& a, BST& b)
    {
        int k = a.root->x;
        d(a.root, b);
    }
    static void d(Node* temp, BST& b)
    {
        b.push(temp->x);
        if (temp->right) { d(temp->right, b); }
        if (temp->left) { d(temp->left, b); }
    }
    static void deleted(BST& a)
    {
        queue <Node*> q;
        q.push(a.root);
        while (!q.empty())
        {
            Node* node = q.front();
            q.pop();

            if (node &&node->left != nullptr)
                q.push(node->left);
            if (node &&node->right != nullptr)
                q.push(node->right);

            free(node);
        }
        a.s = 0;
        a.root = nullptr;

    }
    void printInorder( Node* node)
    {
        if(node->left)
            printInorder(node->left);
        cout << node->x << " ";
        if(node->right)
            printInorder(node->right);
    }
};
template<typename T>
struct BST<T>::iterator
{

    Node* temp;
    iterator() : temp(root) {}

    iterator(Node* temp) : temp(temp) {}

    T& operator*() { return temp->x; }

    iterator& operator++()
    {

        if (temp->right) {
            if (temp->right->left)
            {
                Node* temp2;
                temp2 = temp->right->left;
                while (temp2->left)temp2 = temp2->left;
                temp = temp2;
            }
            else temp = temp->right;
        }
        else
        {
            if (temp->up)
            {
                BST<T>::Node* temp1 = temp;
                while ((temp1->up) && (temp1->up->left != temp1))temp1 = temp1->up;
                if (temp1->up && temp1->up->left == temp1)temp = temp1->up;
                else temp = nullptr;//!!!
            }
            else { temp = nullptr; }//!!!
        }


        return *this;

    }
    iterator operator++(int) {


        if (temp->right) {
            if (temp->right->left)
            {
                Node* temp2;
                temp2 = temp->right->left;
                while (temp2->left)temp2 = temp2->left;
                temp = temp2;
                iterator r(temp);
                return r;
            }
            else {
                iterator r(temp);
                temp = temp->right;
                return r;}
        }
        else
        {
            if (temp->up)
            {
                iterator r(temp);
                Node* temp1 = temp;
                while ((temp1->up) && (temp1->up->left != temp1))temp1 = temp1->up;
                if (temp1->up->left == temp1){
                    temp = temp1->up;
                    return r;
                }
                else  temp=nullptr;
                return r;
            }
            else {
                iterator r(temp);
                temp = nullptr;
                return r;


            }//!!!
        }

    }
    iterator& operator--()
    {
        if (temp) { temp = temp->up; }
        return *this;
    }
    iterator operator--(int) {
        Node* temp1;
        if (temp) temp1 = temp->up;
        else temp1 = temp;
        iterator r(temp1);
        return r;
    }
    iterator& operator=(const iterator& it)
    {
        this->temp = it.temp;
        return *this;
    }
    bool operator==(const iterator& a)const
    {
        return this->temp == a.temp;
    }
    bool operator!=(const iterator& a)const
    {
        return this->temp != a.temp;
    }

};
template<typename T>
BST<T>::BST()
{
    root = nullptr;
}
template<typename T>
BST<T>::~BST()
{
    queue <Node*> q;


    q.push(root);
    while (!q.empty())
    {
        Node* node = q.front();
        q.pop();

        if (node && node->left != nullptr)
            q.push(node->left);
        if (node && node->right != nullptr)
            q.push(node->right);

        free(node);
    }
    s = 0;
}
template<typename T>
BST<T>::BST(const BST<T>& obj)
{//copy
    queue <Node*> q;
    q.push(obj.root);
    while (!q.empty())
    {
        Node* node = q.front();
        q.pop();

        if (node->left != nullptr)
            q.push(node->left);
        if (node->right != nullptr)
            q.push(node->right);

        push(node->x);
    }
}
template<typename T>
BST<T>::BST(BST<T>&& obj)
{//move
    this->root = std::move(obj.root);
    obj.root = nullptr;
    obj.s = 0;

}
template <typename T>
void BST<T>::push(T k)
{
    s++;
    Node* temp = new Node(k);
    temp->right = nullptr;
    temp->left = nullptr;
    temp->up = nullptr;
    if (root == nullptr)
    {
        root = temp;
    }
    else
    {
        Node* temp1 = root;

        while (temp1&&(((temp1->right != nullptr) && (temp1->x < k)) || ((temp1->left != nullptr) && (temp1->x >= k))))
        {
            if (temp1->x < k) { temp1 = temp1->right; }
            else { temp1 = temp1->left; }
        }
        if (temp1->x < k) { temp1->right = temp; }
        else { temp1->left = temp; }
        temp->up = temp1;
    }
}
template <typename T>
int  BST<T>::size()const
{
    return s;
}
template <typename T>
int  BST<T>::findmin()
{
    Node* temp = root;
    while (temp->left != nullptr) { temp = temp->left; }
    return temp->x;

}
template <typename T>
int  BST<T>::findmax()
{
    Node* temp = root;
    while (temp->right != nullptr) { temp = temp->right; }
    return temp->x;

}
template <typename T>
int  BST<T>::deletemin()
{
    if (s != 0)
    {
        s--;
        int k;
        Node* temp = root;
        while (temp->left != nullptr) { temp = temp->left; }
        k = temp->x;
        if (temp != root)
        {
            Node* temp1 = temp->up;
            if (temp->right != nullptr)
            {
                temp1->left = temp->right;
                temp1->left->up = temp1;
            }
            else { temp1->left = nullptr; }
            temp->up = nullptr;
        }
        else {
            if (root->right != nullptr) { root->right->up = nullptr; root = root->right; }
            else root = nullptr;
        }
        return k;
    }
    else cout << "Drzelo jest puste" << endl;
}
template <typename T>
int BST<T>::deletemax()
{
    if (s != 0)
    {
        s--;
        Node* temp = root;
        int k;
        while (temp->right != nullptr) { temp = temp->right; }
        k = temp->x;
        if (temp != root)
        {
            Node* temp1 = temp->up;
            if (temp->left != nullptr)
            {
                temp1->right = temp->left;
                temp1->right->up = temp1;
            }
            else { temp1->right = nullptr; }
            temp->up = nullptr;
        }
        else {
            if (root->left != nullptr) { root->left->up = nullptr; root = root->left; }
            else root = nullptr;
        }
        return k;
    }
    else cout << "Drzelo jest puste" << endl;
}
template <typename T>
void BST<T>::deletew1(Node* temp)
{
    s--;
    if (temp != root)
    {
        if ((temp->left != nullptr) && (temp->right != nullptr))
        {
            //  2 dziecka
            if (temp->right->left == nullptr)
            {

                if (temp->up->left == temp)
                {
                    temp->up->left = temp->right;
                    temp->right->up = temp->up;
                    temp->left->up = temp->right;
                    temp->right->left = temp->left;
                }
                if (temp->up->right == temp)
                {
                    temp->up->right = temp->right;
                    temp->right->up = temp->up;
                    temp->left->up = temp->right;
                    temp->right->left = temp->left;
                }

                free(temp);
            }
            else
            {
                if (temp->right->left != nullptr) {
                    Node* temp1 = temp->right->left;
                    while (temp1->left != nullptr) temp1 = temp1->left;


                    if (temp1->right != nullptr)
                    {
                        temp1->up->left = temp1->right;
                        temp1->right->up = temp1->up;
                    }
                    else
                    {
                        temp1->up->left = nullptr;
                    }

                    if (temp->up->right == temp)
                    {
                        temp->up->right = temp1;
                    }
                    if (temp->up->left == temp)
                    {
                        temp->up->left = temp1;
                    }
                    temp1->up = temp->up;
                    temp1->left = temp->left;
                    temp->left->up = temp1;
                    temp1->right = temp->right;
                    temp->right->up=temp1;



                }
            }

        }
        else
        {
            if ((temp->left == nullptr) && (temp->right == nullptr))
            {
                //nie ma dzieci
                if (temp->up->left == temp) { temp->up->left = nullptr; }
                if (temp->up->right == temp) {
                    temp->up->right = nullptr;
                }
                free(temp);
            }
            else
            {
                //1 dziecko
                if (temp->up->left == temp)
                {

                    if (temp->left != nullptr) { temp->up->left = temp->left; temp->left->up = temp->up; }
                    if (temp->right != nullptr) { temp->up->left = temp->right; temp->right->up = temp->up; }
                    temp->up = nullptr;
                }
                else {
                    if (temp->up->right == temp)
                    {

                        if (temp->left != nullptr) { temp->up->right = temp->left; temp->left->up = temp->up; }
                        if (temp->right != nullptr) { temp->up->right = temp->right; temp->right->up = temp->up; }
                        temp->up = nullptr;
                    }
                }
                free(temp);
            }

        }


    }
    else
    {
        //Korzen
        if ((temp->left != nullptr) && (temp->right != nullptr))
        {
            //2 dziecka
            if (temp->right->left == nullptr)
            {

                temp->right->left = temp->left;
                temp->left->up = temp->right;
                root = temp->right;
                free(temp);
            }
            else
            {
                if (temp->right->left != nullptr) {
                    Node* temp1 = temp->right->left;
                    while (temp1->left != nullptr) temp1 = temp1->left;
                    if (temp1->right != nullptr)
                    {
                        temp1->up->left = temp1->right;
                        temp1->right->up = temp1->up;
                    }
                    else {

                        temp1->up->left = nullptr;
                    }
                    temp1->up = nullptr;

                    temp1->right = temp->right;
                    temp->right->up = temp1;
                    temp1->left = temp->left;
                    temp->left->up = temp1;
                    root = temp1;




                }
            }
            free(temp);
        }
        else
        {
            if ((temp->left == nullptr) && (temp->right == nullptr))
            {
                //nie ma dzieci
                root = nullptr;

            }
            else
            {
                //1 dziecko
                if (temp->left != nullptr) { root = temp->left; temp->left->up = nullptr; }
                else {
                    if (temp->right != nullptr) {
                        root = temp->right; temp->left->up = nullptr;
                    }
                }
            }
            free(temp);
        }
    }

}
template<typename T>
void BST<T>::in_order(Node* p, function<void(const T&)>& f) const{
    if (p) {
        in_order(p->left, f);
        f(p->x);
        in_order(p->right, f);
    }
};

#endif
