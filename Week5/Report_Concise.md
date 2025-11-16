# BÁO CÁO A* ALGORITHM APPLIED TO TRAVELING SALESMAN PROBLEM

## I. TỔNG QUAN

Bài thực hành triển khai **A* Algorithm kết hợp Prim's MST** để giải quyết bài toán Traveling Salesman Problem (TSP) - tìm đường đi ngắn nhất qua tất cả các thành phố.

**Công thức chính:** `f(n) = g(n) + h(n)`
- `g(n)`: Chi phí thực tế từ gốc đến nút n
- `h(n)`: Chi phí ước lượng (heuristic) từ n đến đích

---

## II. CẤU TRÚC CHƯƠNG TRÌNH

### **1. TreeNode Class**
Lưu trữ thông tin nút trong cây tìm kiếm:
- `c_no`: Số hiệu thành phố hiện tại
- `c_id`: ID duy nhất của nút
- `f_value`: f(n) = g(n) + h(n)
- `h_value`: Heuristic value h(n)
- `parent_id`: ID nút cha (truy vết đường đi)

### **2. Graph Class**
Quản lý đồ thị và MST:
- **minKey()**: Tìm nút chi phí tối thiểu chưa trong MST
- **primMST()**: Xây dựng MST bằng Prim's algorithm
- **printMST()**: Tính trọng số MST + chi phí kết nối

### **3. Heuristic Function**
Tính `h(n)` bằng MST của các nút chưa thăm:
1. Xác định tập nút đã thăm và chưa thăm
2. Xây dựng MST của nút chưa thăm
3. Thêm chi phí kết nối từ nút 0 đến MST
4. Thêm chi phí kết nối từ nút đích đến MST

### **4. startTSP Function**
Thuật toán A* chính:
1. Khởi tạo nút gốc, thêm vào fringe list
2. Vòng lặp:
   - Chọn nút có f_value nhỏ nhất
   - Kiểm tra nếu là đích: trả về chi phí
   - Nếu không: mở rộng → thêm nút con vào fringe list
   - Tính `f_val = g(parent) + edge_cost + h(child)`

---

## III. KHÁC BIỆT 2 VERSION CODE

| **Lỗi** | **Code 1** | **Code 2** | **Mức độ** |
|--------|-----------|-----------|----------|
| **printMST param** | Thiếu `g` → undefined `graph` | ✅ Có `g` | 🔴 Critical |
| **primMST param** | Thiếu `g` → TypeError | ✅ Có `g` | 🔴 Critical |
| **Dictionary method** | `.Keys()` (sai) | ✅ `.keys()` | 🔴 Critical |
| **Fringe init** | `[0]` → ID trùng | ✅ `[key=1]` | 🟡 Bug |
| **MST return** | `* 10000` | ✅ `% 10000` | 🟡 Logic |
| **Code style** | Không nhất quán | ✅ Nhất quán | 🟢 Minor |

### **Lỗi Chính trong Code 1:**

**Line 43-48 (printMST):**
```python
# ❌ WRONG - graph undefined
if(graph[0][r_temp[i]] < min1):
```

**Line 136 (heuristic call):**
```python
# ❌ WRONG - missing parameter g
mst_weight = g.primMST(d_temp, t)
```

**Line 181 (Dictionary):**
```python
# ❌ WRONG - .Keys() doesn't exist in Python
for i in fringe_list.Keys():
```

---

## IV. LUỒNG THUẬT TOÁN

```
Input: graph (ma trận kề), V (số thành phố)

1. Khởi tạo: 
   - TreeNode(0, 1, h_value, h_value, -1)
   - fringe_list[1] = FringeNode(0, h_value)

2. Vòng lặp A*:
   LOOP:
     - Chọn nút min_f_value từ fringe_list
     - IF nút = (city 0, depth V): RETURN chi phí ✅
     - ELSE: Mở rộng
       * FOR mỗi thành phố chưa thăm:
         * Tính f_val = g + edge + h
         * Thêm vào fringe_list
         * Tính toán heuristic mới

3. Output: Chi phí đường đi tối ưu
```

---

## V. CÓ CHI TIẾT VỀ A*

### **Tại sao A*?**
- Kết hợp **Greedy Search** (BFS) + **Heuristic** (DFS)
- Luôn chọn nút có tiềm năng tốt nhất
- Nhanh hơn Dijkstra/BFS thuần

### **Tại sao MST Heuristic?**
- Lower bound tốt cho chi phí còn lại
- Chứng minh: MST phần nút chưa thăm < chi phí thực tế
- Giúp A* cắt tỉa tốt hơn

### **Độ Phức Tạp:**
- **Prim's MST**: O(V²) mỗi lần gọi
- **A* overall**: O(N × V²) với N = số nút expand
- Tốt hơn brute force O(V!)

---

## VI. VẤN ĐỀ & CÁCH FIX

| **Vấn đề** | **Nguyên nhân** | **Cách Fix** |
|-----------|---------------|------------|
| Runtime Error | Tham số hàm sai | Truyền `g` vào printMST, primMST |
| AttributeError | `.Keys()` typo | Đổi thành `.keys()` |
| ID Collision | fringe[0] = tree[1] | Dùng fringe[key] với key=1 |
| Heuristic tăng | Nhân 10000 | Dùng modulo % 10000 |

---

## VII. NHẬN XÉT CUỐI CÙNG

### ✅ **Code 2 (Cải tiến):**
- ✓ Không lỗi syntax/logic
- ✓ Tham số truyền đầy đủ
- ✓ Code style nhất quán
- ✓ Có thể chạy ngay

### ❌ **Code 1 (Ban đầu):**
- ✗ 3 lỗi fatal
- ✗ Dùng biến global
- ✗ Không chạy được
- ✗ Design kém

**Kết luận:** Code 2 là phiên bản **sản xuất** có thể sử dụng, Code 1 chỉ là bản draft lỗi.

---

## VIII. KỲ VỌNG KẾT QUẢ

Với đồ thị test 4 nút:
```
graph = [[0,5,2,3], [5,0,6,3], [2,6,0,4], [3,3,4,0]]
```

A* sẽ tìm được **đường đi tối ưu** (ví dụ: 0→2→3→1→0 với chi phí tối thiểu).

---

*Báo cáo ngắn gọn về bài thực hành A* Algorithm cho TSP*